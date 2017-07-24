module Jobs
  class SyncBackupsToDrive < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(args)
      local_backup_files = Backup.all.map(&:filename).take(SiteSetting.discourse_backups_to_drive_quantity)
      local_backup_files each do |backup|
        ::DiscourseBackupToDrive::DriveSynchronizer.new(backup).sync
      end
    end
  end
end
