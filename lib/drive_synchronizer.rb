module DiscourseBackupToDrive
  class DriveSynchronizer < Synchronizer

    def initialize(backup)
      super(backup)
      @api_key = SiteSetting.discourse_backups_drive_api_key
      @turned_on = SiteSetting.discourse_backups_drive_enabled
      # @session = GoogleDrive::Session.from_service_account_key(StringIO.new(@api_key))
    end

    def session
      @session ||= GoogleDrive::Session.from_service_account_key(StringIO.new(@api_key))
    end

    def can_sync?
      @turned_on && @api_key.present? && backup.present?
    end

    protected
    def perform_sync
      session = session
      drive_sess = session
      full_path = backup.path
      filename = backup.filename
      file = drive_sess.upload_from_file(full_path, filename)
      add_to_folder(drive_sess, file)
      ssession.root_collection.remove(file)
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
