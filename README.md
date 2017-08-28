# Discourse Sync to Google Drive
A Plugin for Discourse that does a backup to your Google Drive Service Account

1. Make sure you have the latest version of Discourse set up properly
2. Install the [basic-sync-plugin](https://github.com/berlindiamonds/discourse-sync-base) first
3. Clone this repository into your discourse/plugins folder
4. In the browser go to your admin settings and then to plugins. You should see the discourse-sync-to-googledrive appearing there

![alt text](https://user-images.githubusercontent.com/15628617/28319104-3839c696-6bcd-11e7-90dc-86513339190d.png)

5. Click on the settings and enable the plugin

![alt text](https://user-images.githubusercontent.com/15628617/28319119-44155a20-6bcd-11e7-9bfe-0e2154679ee6.png)

5. Create a [Google Drive Service Account](https://console.developers.google.com/apis)
6. Follow [these steps](https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md) until step 5 (the 3rd option)

![alt text](https://user-images.githubusercontent.com/15628617/28318451-309da67a-6bcb-11e7-8e72-a5f718263610.png)

7. Open the JSON file and copy its content and paste the whole thing into the textfield in your plugin-settings that is called "discourse backups to drive api key" and save it
8. Backup your files

this plugin was created by Jen and Kaja, in analogy to the [discourse-sync-to-dropbox plugin from Falco](https://github.com/xfalcox/discourse-backups-to-dropbox)

For help please go to [Discourse Meta](https://meta.discourse.org/)
