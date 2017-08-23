class DownloadersController < ApplicationController
  skip_before_filter :check_xhr

  def show
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).list_files_json

    respond_to do |format|
      format.json {render json: google_list}
      format.html {render html: google_list}
    end
  end
end
