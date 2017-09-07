// Because of its filename, this controller will automatically be used
// to handle actions from the `downloader.hbs` template
import { ajax } from 'discourse/lib/ajax';

export default Ember.Controller.extend({
  actions: {
    test() {
      alert('button clicked');
    },

    download(file) {
      console.log("hello from the ember action", file)
      file.save();
        // ajax("/admin/plugins/discourse-sync-to-googledrive/downloader/" + file, { type: "PUT" })
        // .then(() => {
        //    bootbox.alert(I18n.t("admin.backups.operations.download.alert"));
        // });
    }
  }
});
