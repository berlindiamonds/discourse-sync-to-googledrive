module DiscourseBackupToDrive
  class DriveSynchronizer < Synchronizer

    protected
    def perform_sync
      session = session_meth
      full_path = backup.path
      filename = backup.filename
      file = session.upload_from_file(full_path, filename)
      add_to_folder(session, file)
      session.root_collection.remove(file)
    end

    def session_meth
      GoogleDrive::Session.from_service_account_key(StringIO.new(@api_key))
    end

    def add_to_folder(session, file)
      folder_name = Discourse.current_hostname
      folder = session.collection_by_title(folder_name)
      if folder.present?
        folder.add(file)
      else
        folder = session.root_collection.create_subcollection(folder_name)
        folder.add(file)
      end
    end
  end
end
