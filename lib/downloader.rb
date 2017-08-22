module Downloader
  class DownloadDrive
    attr_accessor :google_files, :session, :id, :json_files

    def initialize(id)
      @id = pick_file(:id)
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
      @google_files ||= session.collection_by_title(folder_name).files
    end

    def list_files_json
      list_files = google_files.map do |o|
        {title: o.title, id: o.id}
      end
      list_files.to_json
    end

    # puts list_files_json
    # "[{\"title\":\"discourse-2017-08-10-135040-v20170731030330.sql.gz\",\"id\":\"0B9eyEerjltIgamstNDl1YUc2ejQ\"},
    # {\"title\":\"discourse-2017-08-10-135125-v20170731030330.sql.gz\",\"id\":\"0B9eyEerjltIgaHpLLWxLdm84Z1E\"},
    # {\"title\":\"discourse-2017-08-10-135726-v20170731030330.sql.gz\",\"id\":\"0B9eyEerjltIgb0VubjRLN3E0UW8\"},
    # {\"title\":\"discourse-2017-08-10-140920-v20170731030330.sql.gz\",\"id\":\"0B9eyEerjltIgZGFrdGd0VGdFQnc\"},
    # {\"title\":\"discourse-2017-08-10-141214-v20170731030330.sql.gz\",\"id\":\"0B9eyEerjltIgZ2dyUTB1eGNjYUk\"}]"

    protected

    def pick_file(id)
      click on a file from JsonFile
      pick by id
      download a google_file by id
      create a download_link with the google_file
      => id
    end

    def create_url
      found = google_files.select { |f| f.id == id }
      file_title = found.first.title
      file_url = session.collection_by_title(folder_name).file_by_title(file_title).human_url
    end

    def send_link
      put link into an email
      send_mail to user
    end
  end
end
