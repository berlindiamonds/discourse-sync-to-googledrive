module Jobs
  class SyncBackupsToDrive < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(args)
      Backup.all each do |backup|
				::DiscourseBackupToDrive::DriveSynchronizer.new(backup).sync 
			end
    end
  end
end

