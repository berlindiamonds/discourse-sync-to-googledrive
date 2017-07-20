module DiscourseBackupToDrive
  class DriveSynchronizer

    attr_reader :backup

    def initialize(backup)
      @backup = backup
      @api_key = SiteSetting.discourse_backups_to_drive_api_key
      @turned_on = SiteSetting.discourse_backups_to_drive_enabled 
    end


    

    def can_sync?
      @turned_on && @api_key.present? && backup.present?
    end

    def self.sync
      session = GoogleDrive::Session.from_service_account_key(StringIO.new(SiteSetting.discourse_backups_to_drive_api_key))
      folder_name = Discourse.current_hostname
      local_backup_files = Backup.all.map(&:filename).take(SiteSetting.discourse_backups_to_drive_quantity)
      @last_upload = local_backup_files
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

