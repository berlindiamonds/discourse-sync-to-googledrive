# Discourse Backup to Google Drive Service Account

- Make sure you have the latest version of Discourse set up properly
- Clone this repository into your discourse/plugins folder
- Create a credentials JSON file on Google Drive and save it in the disccourse/plugins/discourse-googledrive-backup/config folder
- Before committing your changes make your you write the json file into your gitignore of the plugin
- In the discourse-googledrive-plugin/lib/drive_sychronizer.rb refere to your json file when assigning the session
- further info about the Google Drive API: https://developers.google.com/api-client-library/ruby/auth/service-accounts