module DiscourseBackupToDrive
	class OauthSynchronizer < Synchronizer 

		def initialize(backup)
			super(backup)
			@turned_on 	= SiteSetting.discourse_backups_to_oauth_enabled
			@id 				= client_id_from_settings(SiteSetting.discourse_backups_to_oauth_client_id) #could be also taken 
			@secret 		= client_secret_from_settings(SiteSetting.discourse_backups_to_oauth_client_secret) #from config
			@scope 			= [
									    "https://www.googleapis.com/auth/drive",
									    "https://spreadsheets.google.com/feeds/",
									  ]
			@uri 				= Discourse.redirect_uri(google_oauth)
		end

		def credentials(@credentials)
			@credentials = Google::Auth::UserRefreshCredentials.new(@id, @secret, @scope, @uri)
		end

		def session
			@session 	||= GoogleDrive::Session.from_credentials(@credentials)
		end

		def authorized?
			auth_url 		= @credentials.authorization_uri
			auth_url.present?
		end

		def can_sync?
			@turned_on && authorized? && backup.present?
		end

		protected

		def perform_sync

		end

		def add_to_folder(file)

		end


	end
end