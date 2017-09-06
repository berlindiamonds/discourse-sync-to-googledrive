// Because of its filename, this controller will automatically be used
// to handle actions from the `downloader.hbs` template

export default Ember.Controller.extend({
  actions: {
    test() {
      alert('button clicked');
    },

    download(file) {
      console.log("hello from the ember action", file)
      // let link = backup.get('title');
      // ajax("/admin/plugins/discourse-sync-to-googledrive/downloader/" + link, { type: "PUT" })
      // .then(() => {
      //   bootbox.alert(I18n.t("admin.backups.operations.download.alert"));
      // });
    }
  }
});
