require "email_backup_token"

class DownloadersController < Admin::AdminController
  skip_before_filter :check_xhr
  # skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  def index
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).json_list
    render json: google_list
  end

  def create
    @file_id = params[:file_id]
    Jobs.enqueue(:send_download_drive_link, file_id: @file_id)
    render json: google_list
  end
end
