# name: discourse-backup-to-oauth
# about: -
# version: 1.0
# authors: Kaja & Jen
# url: https://github.com/berlindiamonds/discourse-googledrive-backup

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
require 'googleauth'

enabled_site_setting :discourse_backups_drive_enabled

after_initialize do
  load File.expand_path("../lib/synchronizer.rb", __FILE__)
  load File.expand_path("../app/jobs/regular/sync_backups_to_oauth.rb", __FILE__)
  load File.expand_path("../lib/oauth_synchronizer.rb", __FILE__)

  Discourse::Application.routes.draw do
  	def create_route
  		get "admin#backup" => "admin#plugins"
  	end
  end

  Backup.class_eval do
    def after_create_hook
      Jobs.enqueue(:sync_backups_to_drive)
    end
  end
end
