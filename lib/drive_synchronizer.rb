module DiscourseBackupToDrive
	class DriveSynchronizer
		CHUNK_SIZE = 25600000
		UPLOAD_MAX_SIZE = CHUNK_SIZE * 4

		def self.sync

			session = GoogleDrive::Session.from_config("config.json")
			folder_name = Discourse.current_hostname

			begin
				session.root_collection.create_subcollection(folder_name)
			rescue
				#folder exists
			end

			drive_backup_files = session.root_collection.subcollection_by_title(folder_name).files
			local_backup_files = Backup.all.map(&:filename).take(1)

			(local_backup_files - drive_backup_files).each do |filename|
				full_path = Backup[filename].path
				size = Backup[filename].size
				session.upload_from_file(full_path, filename)
			end

			def self.upload(full_path, filename)
				file = session.upload_from_file(full_path, filename)
				folder_name.add(file)
			end

		end
	end
end
