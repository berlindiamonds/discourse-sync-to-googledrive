# Discourse Backup to Google Drive Service Account

- Make sure you have the latest version of Discourse set up properly
- Clone this repository into your discourse/plugins folder
- In the browser go to your admin settings and then to plugins. You should see the discourse-googledrive-backup appearing there
- click on the settings and enable the plugin
- Create a Google Drive Service Account: https://console.developers.google.com/apis
- Create a credentials JSON file on Google Drive service account and save it 
- Open the JSON file and copy its content and paste the whole thing into the textfield in your plugin-settings that is called "discourse backups to drive api key" and save it
- Backup your files 
- further info about the Google Drive API: https://developers.google.com/api-client-library/ruby/auth/service-accounts

this plugin was created by Jen and Kaja, in analogy to the discourse-backup-to-dropbox plugin from Falco