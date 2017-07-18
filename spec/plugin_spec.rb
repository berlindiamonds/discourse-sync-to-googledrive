require 'spec_helper'
require './lib/drive_synchronizer.rb'
require 'mocha/test_unit'


describe Backup do 
	

	context "#after_create_hook" do
		it "overwrites the Backup#after_create_hook" do 
			expect(Backup.new(nil).after_create_hook).to eq(:hello)
		end

		let(:b1) { Backup.new('backup1') }
	  let(:b2) { Backup.new('backup2') }
	  let(:b3) { Backup.new('backup3') }

	  before do
	    Backup.stubs(:all).returns([b1, b2, b3])
	  end
	  let(:b1) { Backup.new('backup1') }
    context "when SiteSetting is true" do

      before do
        SiteSetting.enable_discourse_backups_to_drive = true
      end

      it "should upload the backup to GoogleDrive with the right paths" do
        b1.path = 'some/path/backup.gz'
        File.expects(:open).with(b1.path).yields(stub)
      end
    end

    it "calls upload_to_s3 if the SiteSetting is false" do
      SiteSetting.enable_discourse_backups_to_drive = false
      b1.expects(:session.upload).never
    end
	end
end
