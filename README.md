# Discourse Backup to Google Drive Service Account

- Make sure you have the latest version of Discourse set up properly
- Clone this repository into your discourse/plugins folder
- In the browser go to your admin settings and then to plugins. You should see the discourse-googledrive-backup appearing there
- Click on the settings and enable the plugin
- Create a Google Drive Service Account: https://console.developers.google.com/apis
- Follow these steps until step 5

![alt text](https://user-images.githubusercontent.com/15628617/28318451-309da67a-6bcb-11e7-8e72-a5f718263610.png)

from https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md (the 3rd option)

- Create a credentials JSON file on Google Drive service account and save it 
- Open the JSON file and copy its content and paste the whole thing into the textfield in your plugin-settings that is called "discourse backups to drive api key" and save it
- Backup your files 

this plugin was created by Jen and Kaja, in analogy to the discourse-backup-to-dropbox plugin from Falco