module Jobs
  class SyncBackupsToDrive < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(args)
      ::DiscourseBackupToDrive::DriveSynchronizer.new(backup) 
    end
  end
end
