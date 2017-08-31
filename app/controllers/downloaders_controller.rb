require "email_backup_token"

class DownloadersController < ApplicationController
  skip_before_filter :check_xhr
  # skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  def index
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).json_list

    respond_to do |format|
      format.json {render json: google_list}
      format.html {render html: google_list}
    end
  end

  def create
    @file_id = params[:file_id]
    Jobs.enqueue(:send_download_drive_link, file_id: @file_id)
    respond_to do |format|
      format.json {render json: @file_id}
      format.html {render html: @file_id}
    end
  end
end
