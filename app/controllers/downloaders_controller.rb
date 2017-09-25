require "email_backup_token"
require_relative "../jobs/regular/send_download_drive_link.rb"

class DownloadersController < Admin::AdminController
  requires_plugin 'discourse-sync-to-googledrive'
  skip_before_action :check_xhr, only: [:show]

  def index
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).json_list
    render json: google_list
  end

  def create
    file_id = params.fetch(:file_id)
    token = EmailBackupToken.set(current_user.id)
    file_path = DiscourseDownloadFromDrive::DriveDownloader.new(file_id).download
    download_url = "#{url_for(controller: 'downloaders', action: 'show')}?token=#{token}"
    Jobs.enqueue(:send_download_drive_link, to_address: current_user.email, drive_url: download_url)
    render nothing: true
  end

  def show
    if !EmailBackupToken.compare(current_user.id, params.fetch(:token))
      @error = I18n.t('download_backup_mailer.no_token')
    end
    if !@error
      file_id = params.fetch(:file_id)
      filename = DiscourseDownloadFromDrive::DriveDownloader.new(file_id).filename
      file_path = File.join(Backup.base_directory, filename)
      EmailBackupToken.del(current_user.id)
      send_file file_path
    else
      if @error
        render layout: 'no_ember', status: 422, text: "this link has already been used and is therefore expired"
      else
        render nothing: true, status: 404
      end
    end
  end
end
