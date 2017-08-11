module DiscourseBackupToDrive
  class DriveSynchronizer < Synchronizer

    def initialize(backup)
      super(backup)
      @api_key = SiteSetting.discourse_sync_to_googledrive_api_key
      @turned_on = SiteSetting.discourse_sync_to_googledrive_enabled
      @folder_name = Discourse.current_hostname
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
      google_folder = session.collection_by_title(folder_name)
      create_folder(google_folder, folder_name)
      full_path = backup.path
      filename = backup.filename
      file = session.upload_from_file(full_path, filename)
      upload_unique_files(file, folder_name)
    end

    def upload_unique_files(file, folder_name)
      google_files = session.collection_by_title(folder_name).files.map(&:title)
      ([backup].map(&:filename) - google_files).each do |f|
        if f.present?
          add_to_folder(folder_name, file)
          session.root_collection.remove(file)
        end
      end
    end

    def add_to_folder(folder_name, file)
      session.collection_by_title(folder_name).add(file)
    end

    def create_folder(google_folder, folder_name)
      unless google_folder.present?
        google_folder = session.root_collection.create_subcollection(folder_name)
      else
        nil
      end
    end

  end
end
