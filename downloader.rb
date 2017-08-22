module Downloader
  class JsonFile
    attr_accessor :files, :session

    def session
      @session ||= GoogleDrive::Session.from_service_account_key(StringIO.new(SiteSetting.discourse_sync_to_googledrive_api_key))
    end

    def files
      @files ||= session.collection_by_title(folder_name).files
    end

    def self.parse_files
      download_list = files.each.map do|t|
        { title: t.title, id: t.id }
      end

        download = JsonFile.new
        download.files = JSON.parse(download_list)

      return json_files
    end
  end

  class DownloadLink
    attr_accessor :id, :json_files

    def initialize
      @id = JsonFile.new(:id)


    end


    def pick_file
      click on a file from JsonFile
      pick by id
      download a google_file by id
      create a download_link with the google_file
    end

    def download_file
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