require 'googleauth'
require 'google/apis/compute_v1'

class GoogleService

	attr_accessor :compute, :scopes, :session

	#def initialize
	#	@compute = compute
	#	@scopes = scopes
	#end

	def create_service(compute, scopes, session)
		compute = Google::Apis::ComputeV1::ComputeService.new
	#end

	#def get_auth(compute, scopes)
		# Get the environment configured authorization
		scopes =  ['https://www.googleapis.com/auth/cloud-platform', 'https://www.googleapis.com/auth/compute']
		authorization = Google::Auth.get_application_default(scopes)
		auth_client.fetch_access_token!
	end

end


 	# don't know what this is for:
 	# require "google/apis/storage_v1"
    # storage = Google::Apis::StorageV1::StorageService.new
    # storage.authorization = authorization
    # from: https://developers.google.com/identity/protocols/application-default-credentials