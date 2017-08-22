module Downloader
  class DownloadDrive
    attr_accessor :files, :session, :id, :json_files

    def initialize
      @id = JsonFile.new(:id)
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

    def pick_file
      click on a file from JsonFile
      pick by id
      download a google_file by id
      create a download_link with the google_file
    end

    def create_link
      download a google_file by id
      create a download_link with the google_file
    end

    def send_link
      put link into an email
      send_mail to user
    end
  end
end
JsonFile.new(:id)

file = DownloadLink.new(:id)
file.send_link


# require 'json'
# # => true
# h = {a: 1, b: 2,c: 3}
# # => {a: 1, b: 2,c: 3}
# h.to_json
# # => "{\"a\":1,\"b\":2,\"c\":3}"


# companies = []

# data_hash.each do |hash|
#   companies << hash
# end

# companies_json = companies.to_json

# def download_files
#       download_list = Document.new
#       download_list.metadata = JSON.parse(txt)
#       google_files = session.collection_by_title(folder_name).files
#       google_files.each { |p| }
#     end

#     google_files = session.collection_by_title(@folder_name).files
#        sorted = google_files.sort_by {|x| x.created_time}
