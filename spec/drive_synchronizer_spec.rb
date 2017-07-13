require 'drive_synchronizer'

describe DriveSynchronizer do 
	describe ".sync" do
		context "loads wrong json file" do
			it "doesn't create a session" do
				expect(session).to_be nil 
			end
		end
	end
end