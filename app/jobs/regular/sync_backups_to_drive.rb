module Jobs
  class SyncBackupsToDrive < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      Backup.all.take(1).each {|backup| DiscourseBackupToDrive::DriveSynchronizer.new(backup).sync }
    end
  end
end
