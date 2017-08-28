module DiscourseDownloadFromDrive
  class DriveDownloader
    attr_accessor :google_files, :session, :id

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
      folder_name = Discourse.current_hostname
      @google_files ||= session.collection_by_title(folder_name).files
    end

    def list_files_json
      list_files = google_files.map do |o|
        {title: o.title, id: o.id, size: o.size, created_at: o.created_time}
      end
      {"files" => list_files}.to_json
    end

    # "{\"files\":
    #   [
    #     {\"title\":\"discourse-2017-08-10-135040-v20170731030330.sql.gz\",\"id\":\"0B9eyEerjltIgamstNDl1YUc2ejQ\",\"size\":12067733,\"time\":\"2017-08-10T15:17:00+00:00\"},
    #     {\"title\":\"discourse-2017-08-10-135125-v20170731030330.sql.gz\",\"id\":\"0B9eyEerjltIgaHpLLWxLdm84Z1E\",\"size\":12122496,\"time\":\"2017-08-10T15:16:50+00:00\"},
    #     {\"title\":\"discourse-2017-08-10-135726-v20170731030330.sql.gz\",\"id\":\"0B9eyEerjltIgb0VubjRLN3E0UW8\",\"size\":12177845,\"time\":\"2017-08-10T15:16:37+00:00\"},
    #     {\"title\":\"discourse-2017-08-10-140920-v20170731030330.sql.gz\",\"id\":\"0B9eyEerjltIgZGFrdGd0VGdFQnc\",\"size\":12233758,\"time\":\"2017-08-10T15:16:26+00:00\"},
    #     {\"title\":\"discourse-2017-08-10-141214-v20170731030330.sql.gz\",\"id\":\"0B9eyEerjltIgZ2dyUTB1eGNjYUk\",\"size\":12288259,\"time\":\"2017-08-10T15:16:14+00:00\"}
    #   ]
    # }"

    def pick_file(id)
      # click on a file from JsonFile sends a POST :id to create
      # something like a <%= select_tag(:id) %>
      # pick by id from the view
      # google_files.id(picked)
      # returns id
    end

    def create_url
      folder_name = Discourse.current_hostname
      found = google_files.select { |f| f.id == id }
      file_title = found.first.title
      file_url = session.collection_by_title(folder_name).file_by_title(file_title).human_url
    end
  end
end
