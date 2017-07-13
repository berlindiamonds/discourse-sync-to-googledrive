require 'drive_synchronizer'

describe DriveSynchronizer do 
	describe ".sync" do
		context "loads the right credentials from the config.json" do
			it "creates a session" do
				expect(session).to_not_be nil 
			end
		end
	end
end