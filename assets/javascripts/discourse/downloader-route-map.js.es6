export default {
  resource: 'admin.adminPlugins',
  map() {
    // We want `discourse-sync-to-googledrive/downloader` in this case
    this.route('discourse-sync-to-googledrive', { resetNamespace: true }, function() {
      this.route('downloader');
    });
  }
};
