require "email_backup_token"
require_relative "../jobs/regular/send_download_drive_link.rb"

class DownloadersController < Admin::AdminController
  requires_plugin 'discourse-sync-to-googledrive'
  skip_before_filter :check_xhr, only: [:show]

  def index
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).json_list
    render json: google_list
  end

  def create
    file_id = params.fetch(:file_id)
    # file_id = "0Byyflt8z3jarVlc2NjZCdzBFOFk"
    file_path = DiscourseDownloadFromDrive::DriveDownloader.new(file_id).download
    download_url = "#{url_for(controller: 'downloaders', action: 'show')}"
    Jobs.enqueue(:send_download_drive_link, to_address: 'teamberlindiamonds@gmail.com', drive_url: download_url)
    render nothing: true
  end

  def show
    file_id = params.fetch(:file_id)
    filename = DiscourseDownloadFromDrive::DriveDownloader.new(file_id).filename
    file_path = File.join(Backup.base_directory, filename)
    # EmailBackupToken.del(current_user.id)
    send_file file_path
  end
end
