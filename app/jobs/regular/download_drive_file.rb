module Jobs
  class SyncBackupsToDrive < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      to_address = args[:to_address]
      download = DownloadDrive.new
      file_url = download.create_url

      raise Discourse::InvalidParameters.new(:to_address) if to_address.blank?
      raise Discourse::InvalidParameters.new(:file_url) if file_url.blank?

      message = DownloadBackupMailer.send_email(to_address, file_url)
      Email::Sender.new(message, :download_backup_message).send
    end
  end
end