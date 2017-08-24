class DownloadersController < ApplicationController
  skip_before_filter :check_xhr

  def show
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).list_files_json

    respond_to do |format|
      format.json {render json: google_list}
      format.html {render html: google_list}
    end
  end

  def email
    if id = DiscourseDownloadFromDrive::DriveDownloader.new(nil).file_by_id
      token = EmailBackupToken.set(current_user.id)
      download_url = "#{url_for(controller: 'downloaders', action: 'show')}?token=#{token}"
      Jobs.enqueue(:download_drive_email, to_address: current_user.email, drive_file_path: download_url)
      render nothing: true
     else
       render nothing: true, status: 404
     end
  end

end
