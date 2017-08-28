require 'google_drive'
require 'json'

@api_key = SiteSetting.discourse_sync_to_googledrive_api_key

session = GoogleDrive::Session.from_service_account_key(StringIO.new(@api_key))
raw_files = session.collection_by_title('localhost').files

# def list_files_json
  list_files = raw_files.map do |o|
    {title: o.title, id: o.id}
  end
  list_files.to_json
# end

#def choose_file
  p "which file do you want to pick? write ID"
  session.files.each do |file|
    p file.title
  end
#end

this_one = gets.chomp

file_collection = session.collection_by_title("localhost").files

# def create_url
  found = file_collection.select { |f| f.id == this_one }
  file_title = found.first.title
  file_url = session.collection_by_title('localhost').file_by_title(file_title).human_url
#end
