require "email_backup_token"

class DownloadersController < Admin::AdminController
<<<<<<< HEAD

  def index
    @google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).json_list
    render json: @google_list
=======
  requires_plugin 'discourse-sync-to-googledrive'

  def index
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).json_list
    render json: google_list
>>>>>>> 1de56de0d793f1a5a3baf1a4f7f487b0a4c6c640
  end

  def create
    @file_id = params[:file_id]
    Jobs.enqueue(:send_download_drive_link, file_id: @file_id)
<<<<<<< HEAD
    render json: @google_list
=======
    render json: { file_id: @file_id }
>>>>>>> 1de56de0d793f1a5a3baf1a4f7f487b0a4c6c640
  end
end
