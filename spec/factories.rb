FactoryGirl.define do
	factory :sync do
		session  "#<GoogleDrive::Session:0x3ff293975f48>"
		folder_name  "local Horst"
		local_backup_files ["file1", "file2", "file3"]
	end


# This will guess the User class
#FactoryGirl.define do
 # factory :user do
 #   first_name "John"
 #   last_name  "Doe"
 #   admin false
 # end

  # This will use the User class (Admin would have been guessed)
 # factory :admin, class: User do
 #   first_name "Admin"
 #   last_name  "User"
 #   admin      true
  #end
#end