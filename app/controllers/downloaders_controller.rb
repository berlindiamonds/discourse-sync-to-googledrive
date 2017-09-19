require "email_backup_token"
require_relative "../jobs/regular/send_download_drive_link.rb"

class DownloadersController < Admin::AdminController
  requires_plugin 'discourse-sync-to-googledrive'

  def index
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).json_list
    render json: google_list
  end

  def create
    file_id = params.fetch(:file_id)
    # file_id = "0Byyflt8z3jarVlc2NjZCdzBFOFk"
    file_path = DiscourseDownloadFromDrive::DriveDownloader.new(file_id).download
    puts ">>>>>>>>>>>>>>>>>>>>>>> #{file_path}"
    Jobs.enqueue(:send_download_drive_link, to_address: 'teamberlindiamonds@gmail.com', drive_url: file_path)
    render nothing: true
  end

  # def show
  #   render nothing: true
  #   # user is directed here to download the file after clicking in email
  # end
end
