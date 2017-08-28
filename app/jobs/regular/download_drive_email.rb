require_dependency 'email/sender'

module Jobs
  class DownloadDriveEmail < ::Jobs::Base

    sidekiq_options queue: 'critical'

    def execute(args)
      to_address = args[:to_address]
      # id = DiscourseDownloadFromDrive::DriveDownloader.new(nil).file_by_id
      drive_file_path = args[:drive_url]

      raise Discourse::InvalidParameters.new(:to_address) if to_address.blank?
      raise Discourse::InvalidParameters.new(:drive_file_path) if drive_file_path.blank?

      message = DownloadBackupMailer.send_email(to_address, drive_file_path)
      Email::Sender.new(message, :download_backup_message).send
    end
  end
end
