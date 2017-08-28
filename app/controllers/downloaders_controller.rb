class DownloadersController < ApplicationController
  skip_before_filter :check_xhr

  def show
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).list_files_json

    respond_to do |format|
      format.json {render json: google_list}
      format.html {render html: google_list}
    end

    def create
      download = DiscourseDownloadFromDrive::DriveDownloader.new
      id = download.pick_file(params[:id])
      Job.enqueue(:send_download_drive_link, id: id)
    end
  end
end
