module Jobs
  class SyncBackupsToOauth < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      Backup.all.take(SiteSetting.discourse_backups_drive_quantity).each {|backup| DiscourseBackupToDrive::OauthSynchronizer.new(backup).sync }
    end
  end
end
