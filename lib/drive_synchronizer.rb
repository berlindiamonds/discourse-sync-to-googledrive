module DiscourseBackupToDrive
  class DriveSynchronizer
    def self.sync

      #session = GoogleDrive::Session.from_config("config.json")
      session = GoogleDrive::Session.from_service_account_key("#{Dir.pwd}/lib/config.json")

      folder_name = Discourse.current_hostname

      local_backup_files = Backup.all.map(&:filename).take(SiteSetting.discourse_backups_to_drive_quantity)

      local_backup_files.each do |filename|
        full_path = Backup[filename].path
        file = session.upload_from_file(full_path, filename)
        folder = session.collection_by_title(folder_name)
        if folder.present?
          folder.add(file)
        else
          folder = session.root_collection.create_subcollection(folder_name)
          folder.add(file)
        end
        session.root_collection.remove(file)
      end
    end

  end
end
