module DiscourseBackupToDrive
  class OauthSynchronizer < Synchronizer

    def initialize(backup)
      super(backup)
      @turned_on  = SiteSetting.discourse_backups_to_oauth_enabled
      @id         = client_id_from_settings(SiteSetting.discourse_backups_to_oauth_client_id)
      @secret     = client_secret_from_settings(SiteSetting.discourse_backups_to_oauth_client_secret)
      @scope      = [
                      "https://www.googleapis.com/auth/drive",
                      "https://spreadsheets.google.com/feeds/",
                    ]
      @uri        = Discourse.create_route(auth_url).redirect_uri
    end

    def credentials(@credentials)
      @credentials ||= Google::Auth::UserRefreshCredentials.new(@id, @secret, @scope, @uri)
    end

    def session
      credentials.code = authorization_code
      credentials.fetch_access_token!
      if @session.expired
        credentials.refresh_token = refresh_token
      end
      @session  ||= GoogleDrive::Session.from_credentials(@credentials)
    end

    def authorized?(auth_url)
      auth_url    = credentials.authorization_uri
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