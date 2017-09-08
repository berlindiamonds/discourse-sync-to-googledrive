require "email_backup_token"

class DownloadersController < Admin::AdminController
  requires_plugin 'discourse-sync-to-googledrive'

  def index
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).json_list
    render json: google_list
  end

  def email
    download_url = "#{url_for(controller: 'downloaders', action: 'show')}"
    Jobs.enqueue(:download_drive_email, to_address: 'example@email.com', drive_url: download_url)
    render nothing: true
  end

  def show
    file_id = params.fetch(:file_id)
    file_path = DiscourseDownloadFromDrive::DriveDownloader.new(file_id).download
    @backup = File.open(file_path)
    if @error
      render layout: 'no_ember', status: 422
    else
      render nothing: true, status: 404
    end

  end

end
