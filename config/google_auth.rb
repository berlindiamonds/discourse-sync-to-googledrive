

require 'googleauth'
require 'google_drive'


class GoogleAuthorization
	

	attr_accessor :credentials, :session

	#def initialize(credentials, session)
	#	@credentials = credentials
	#	@session = session
	#end

	def authorize(credentials) 
		credentials = Google::Auth::UserRefreshCredentials.new(
		  client_id: "...",
		  client_secret: "...",
		  scope: [
		    "https://www.googleapis.com/auth/drive",
		    "https://spreadsheets.google.com/feeds/",
		  ],
		  redirect_uri: "http://localhost:3000/google_authorization/redirect")
		auth_url = credentials.authorization_uri
	
		credentials.code = authorization_code
		credentials.fetch_access_token!
		session = GoogleDrive::Session.from_credentials(credentials)
	end

	#def restore(session, credentials)
	#	redentials.refresh_token = refresh_token
	#	@credentials.fetch_access_token!
	#	session = GoogleDrive::Session.from_credentials(@credentials)
	#end
end
 


