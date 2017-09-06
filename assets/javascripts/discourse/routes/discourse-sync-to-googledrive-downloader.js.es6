// Because of its filename, this route will be used after the route matches
// the route map. It's `model` hook will be called to load the data before
// the template is rendered and a loading spinner will show up

import { ajax } from 'discourse/lib/ajax';

export default Ember.Route.extend({
  model() {
    return ajax("/admin/plugins/discourse-sync-to-googledrive/downloader.json");
  }
});
