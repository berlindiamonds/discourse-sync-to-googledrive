module DiscourseBackupToDrive
  class DriveSynchronizer < Synchronizer

    def initialize(backup)
      super(backup)
      @api_key = SiteSetting.discourse_sync_to_googledrive_api_key
      @turned_on = SiteSetting.discourse_sync_to_googledrive_enabled
    end

    def session
      @session ||= GoogleDrive::Session.from_config("config.json")
    end

    def can_sync?
      @turned_on && @api_key.present? && backup.present?
    end

    def delete_old_files
      folder_name = Discourse.current_hostname
      google_files = session.collection_by_title(folder_name).files
      keep = google_files.take(SiteSetting.discourse_sync_to_googledrive_quantity)
      trash = google_files - keep
      trash.each { |d| d.delete(true) }
    end

    protected

    def perform_sync
      folder_name = Discourse.current_hostname
      full_path = backup.path
      filename = backup.filename
      file = session.upload_from_file(full_path, filename)
      unless session.collection_by_title(folder_name) == nil
        upload_unique_files(file, folder_name)
      else
        add_to_folder(file, folder_name)
      end
    end

    def upload_unique_files(file, folder_name)
      ([backup] - session.collection_by_title(folder_name).files).each do |f|
        if f.present?
          add_to_folder(file, folder_name)
        end
      end
    end

    def add_to_folder(file, folder_name)
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
