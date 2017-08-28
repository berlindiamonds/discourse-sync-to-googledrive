class DownloadersController < ApplicationController
  skip_before_filter :check_xhr, :handle_unverfied_request
  # skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  def show
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).list_files_json

    respond_to do |format|
      format.json {render json: google_list}
      format.html {render html: google_list}
    end
  end

  def create
    @id = params[:id]
    Jobs.enqueue(:send_download_drive_link, id: @id)
  end
end