require "email_backup_token"

class DownloadersController < Admin::AdminController
  requires_plugin 'discourse-sync-to-googledrive'

  def index
    google_list = DiscourseDownloadFromDrive::DriveDownloader.new(nil).json_list
    render json: google_list
  end

  # def create
  #   file_id = params.fetch(:file_id)
  #   #file_id = "0Byyflt8z3jarbm5DZGNNVXZSWjg"
  #   file_path = DiscourseDownloadFromDrive::DriveDownloader.new(file_id).download
  #   @backup = File.open(file_path)
  #   # puts @backup
  #   # puts @backup.path
  #   Rails.logger.debug(">>>>>>>>>>>>>>>>>>> @BACKUP >>>>>>>>>>>: #{@backup}")
  # end

  def email
    # @file_id = DiscourseDownloadFromDrive::DriveDownloader[params.fetch(:file_id)]
    #   token = EmailBackupToken.set(current_user.id)
    download_url = "#{url_for(controller: 'downloaders', action: 'show')}"
    Jobs.enqueue(:download_drive_email, to_address: 'example@email.com', drive_url: download_url)
    render nothing: true
    #   render nothing: true
    # else
    #   render nothing: true, status: 404
    # end
  end

  def show
    file_id = params.fetch(:file_id)
    file_path = DiscourseDownloadFromDrive::DriveDownloader.new(file_id).download
    #backup = File.open(file_path)
    if @error
      render layout: 'no_ember', status: 422
    else
      render nothing: true, status: 404
    end
    # # puts  params.fetch(:file_id)
    # Rails.logger.debug(">>>>>>>>>>>>>>>>>>> PARAMS >>>>>>>>>>>>>>>>>>: #{params.fetch(:file_id).inspect}")
    # # "0Byyflt8z3jarbm5DZGNNVXZSWjg"
    # Rails.logger.debug(">>>>>>>>>>>>>>>>>>> @BACKUP >>>>>>>>>>>: #{@backup.inspect}")
    # Rails.logger.debug(">>>>>>>>>>>>>>>>>>> @BACKUP.PATH >>>>>>>>>>>: #{@backup.path}")
    #
    # render plain: 'hello, I am render plain!'
  end

end
