require "email_backup_token"

class DownloadersController < Admin::AdminController

  def index
    @google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).json_list
    render json: @google_list
  end

  def create
    @file_id = params[:file_id]
    Jobs.enqueue(:send_download_drive_link, file_id: @file_id)
    render json: @google_list
  end
end
