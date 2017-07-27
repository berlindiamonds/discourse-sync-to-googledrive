module Jobs
  class SyncBackupsToDrive < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      Backup.all.take(SiteSetting.discourse_backups_drive_quantity).each do |backup|
        DiscourseBackupToDrive::DriveSynchronizer.new(backup).sync
      end
    end
  end
end
