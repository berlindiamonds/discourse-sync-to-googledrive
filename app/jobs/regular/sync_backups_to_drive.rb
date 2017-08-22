module Jobs
  class SyncBackupsToDrive < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      backups = Backup.all.take(SiteSetting.discourse_sync_to_googledrive_quantity)
      backups.each do|backup|
        DiscourseBackupToDrive::DriveSynchronizer.new(backup).sync
      end
      DiscourseBackupToDrive::DriveSynchronizer.new(backups).delete_old_files
    end
  end
end