require "email_backup_token"

class DownloadersController < ApplicationController
  skip_before_filter :check_xhr

  def show
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).json_list

    respond_to do |format|
      format.json {render json: google_list}
      format.html {render html: google_list}
    end
  end

  def email
    download_url = DiscourseDownloadFromDrive::DriveDownloader.new(id).create_url
    # download_url = DiscourseDownloadFromDrive::DriveDownloader.google_files[params:fetch(:id)]
    Jobs.enqueue(:download_drive_email, to_address: current_user.email, drive_file_path: download_url)
    render nothing: true
  end

end
