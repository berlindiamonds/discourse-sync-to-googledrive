module Jobs
  class SyncBackupsToDrive < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      many_backups = Backup.all.take(SiteSetting.discourse_backups_drive_quantity)
      many_backups.each do|backup|
        DiscourseBackupToDrive::DriveSynchronizer.new(backup).sync
      end
    end
  end
end
