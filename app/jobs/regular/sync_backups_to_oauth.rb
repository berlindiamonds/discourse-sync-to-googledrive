module Jobs
  class SyncBackupsToOauth < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      Backup.all.take(SiteSetting.discourse_sync_to_googledrive_quantity).each do
        |backup| DiscourseBackupToDrive::OauthSynchronizer.new(backup).sync
      end
    end
  end
end