# name: discourse-sync-to-googledrive
# about: -
# version: 1.0
# authors: Kaja & Jen
# url: https://github.com/berlindiamonds/discourse-sync-to-googledrive

gem 'httpclient', '2.8.3', { require: false }
gem 'signet', '0.7.3', { require: false }
gem 'os', '0.9.6', { require: false }
gem 'memoist', '0.16.0', { require: false }
gem 'little-plugger', '1.1.4', { require: false }
gem 'logging', '2.2.2', { require: false }
gem 'googleauth', '0.5.1', { require: false }
gem 'hurley', '0.2', { require: false }
gem 'retriable', '3.0.2', { require: false }
gem 'declarative-option', '0.1.0', { require: false }
gem 'declarative', '0.0.9', { require: false }
gem 'uber', '0.1.0', { require: false }
gem 'representable', "3.0.4", { require: false }
gem 'google-api-client', "0.10.3", { require: false }

gem 'google_drive', '2.1.2'
require 'sidekiq'

enabled_site_setting :discourse_sync_to_googledrive_enabled

after_initialize do

  load File.expand_path("../app/jobs/regular/sync_backups_to_drive.rb", __FILE__)
  load File.expand_path("../app/jobs/regular/send_download_drive_link.rb", __FILE__)
  load File.expand_path("../lib/drive_synchronizer.rb", __FILE__)
  load File.expand_path("../lib/drive_downloader.rb", __FILE__)
  load File.expand_path("../app/controllers/downloaders_controller.rb", __FILE__)


  DiscourseEvent.on(:backup_created) do
    Jobs.enqueue(:sync_backups_to_drive)
  end

  Discourse::Application.routes.append do
    get "/admin/plugins/discourse-sync-to-googledrive/downloader" => "downloaders#index"
    get "/admin/plugins/discourse-sync-to-googledrive/downloader/:file_id" => "downloaders#show"
    put "/admin/plugins/discourse-sync-to-googledrive/downloader/:file_id" => "downloaders#create"
  end

end
