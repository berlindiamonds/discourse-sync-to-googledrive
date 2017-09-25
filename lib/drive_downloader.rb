module DiscourseDownloadFromDrive
  class DriveDownloader

    attr_accessor :google_files, :session, :file_id

    def initialize(file_id)
      @file_id = file_id
      @api_key = SiteSetting.discourse_sync_to_googledrive_api_key
      @turned_on = SiteSetting.discourse_sync_to_googledrive_enabled
    end

    def session
      @session ||= GoogleDrive::Session.from_service_account_key(StringIO.new(@api_key))
    end

    def can_download?
      @turned_on && @api_key.present? && @file_id.present?
    end

    def google_files
      folder_name = Discourse.current_hostname
      @google_files ||= session.collection_by_title(folder_name).files
    end

    def json_list
      list_files = google_files.map do |o|
        {title: o.title, file_id: o.id, size: o.size, created_at: o.created_time}
      end
      {"files" => list_files}.to_json
    end

    def download
      file = session.file_by_title(filename)
      path = File.join(Backup.base_directory, filename)
      file.download_to_file("#{path}")
      path
    end

    def filename
      @filename ||= google_files.select { |f| f.id == file_id }.first.title
    end

  end
end
