class DownloadController < ApplicationController
  skip_before_filter :check_xhr

  def create
    google_list = DownloadDrive.new(id).list_files_json
    
    respond_to do |format|
      format.json {render json: google_list}
      format.html {render html: google_list}
    end
  end
end
