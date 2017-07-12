# name: discourse-backup-to-googledrive
# about: -
# version: 1.0
# authors: Kaja & Jen

require 'google_drive'
require 'sidekiq'

enabled_site_setting :discourse_backups_to_drive_enabled

after_initialize do
	load File.expand_path("../config/google_service.rb", __FILE__)
	load File.expand_path("../app/jobs/regular/sync_backups_to_drive.rb", __FILE__)
	load File.expand_path("../lib/drive_synchronizer.rb", __FILE__)

	Backup.class_eval do
		def after_create_hook
			Jobs.enqueue(:sync_backups_to_drive)
		end
	end
end
