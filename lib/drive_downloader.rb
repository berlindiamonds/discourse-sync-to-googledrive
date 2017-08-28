module DiscourseDownloadFromDrive
  class DriveDownloader

    attr_accessor :google_files, :session, :id

    def initialize(id)
      @id = id
      @api_key = SiteSetting.discourse_sync_to_googledrive_api_key
      @turned_on = SiteSetting.discourse_sync_to_googledrive_enabled
    end

    def session
      @session ||= GoogleDrive::Session.from_service_account_key(StringIO.new(@api_key))
    end

    def can_download?
      @turned_on && @api_key.present? && @id.present?
    end

    def google_files
      folder_name = Discourse.current_hostname
      @google_files ||= session.collection_by_title(folder_name).files
    end

    def list_json
      list_files = google_files.map do |o|
        {title: o.title, id: o.id, size: o.size, created_at: o.created_time}
      end
      {"files" => list_files}.to_json
    end

    def file_by_id
      id = '0B7WjYjWZJv_4MENlYUM2SjkyU1E' # for testing
      # click on a file from JsonFile
      # pick by id
      # download a google_file by id
      # create a download_link with the google_file
      #  id
    end

    def create_url
      folder_name = Discourse.current_hostname
      found = google_files.select { |f| f.id == id }
      file_title = found.first.title
      file_url = session.collection_by_title(folder_name).file_by_title(file_title).human_url
    end
  end
end
