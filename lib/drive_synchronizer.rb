module DiscourseBackupToDrive
  class DriveSynchronizer < Synchronizer 

    protected
    def perform_sync
      session = GoogleDrive::Session.from_service_account_key(StringIO.new(@api_key))
      folder_name = Discourse.current_hostname
      local_backup_files = Backup.all.map(&:filename).take(@number_of_backups)
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
