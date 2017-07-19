require 'rails_helper'

describe ::DiscourseBackupToDrive::DriveSynchronizer do

<<<<<<< HEAD
# comment this out cause when running test with this mocks, i get 
# Failure/Error: full_path = Backup[filename].path
# NoMethodError:
# undefined method `path' for nil:NilClass

  #let(:b1) { Backup.new('backup1') }
  #let(:b2) { Backup.new('backup2') }
  #let(:b3) { Backup.new('backup3') }

  #before do
  #  allow(Backup).to receive(:all).and_return([b1, b2, b3])
  #end
=======
  let(:backup) { Backup.new('backup') }

  describe "#backup" do
    it "has a reader method for the backup" do
      ds = described_class.new(backup)
      expect(ds.backup).to eq(backup)
    end
  end
>>>>>>> master

  describe "#can_sync?" do
    it "should return false when disabled via site setting" do
      SiteSetting.discourse_backups_to_drive_enabled = false
      SiteSetting.discourse_backups_to_drive_api_key = 'test_key'
      ds = described_class.new(backup)
      expect(ds.can_sync?).to eq(false)
    end

    it "should return false when the backup is missing" do
      SiteSetting.discourse_backups_to_drive_enabled = true
      SiteSetting.discourse_backups_to_drive_api_key = 'test_key'
      ds = described_class.new(nil)
      expect(ds.can_sync?).to eq(false)
    end

    it "should return false when the api key is missing" do
      SiteSetting.discourse_backups_to_drive_enabled = true
      SiteSetting.discourse_backups_to_drive_api_key = ''
      ds = described_class.new(backup)
      expect(ds.can_sync?).to eq(false)
    end

    it "should return true when everything is correct" do
      SiteSetting.discourse_backups_to_drive_enabled = true
      SiteSetting.discourse_backups_to_drive_api_key = 'test_key'
      ds = described_class.new(backup)
      expect(ds.can_sync?).to eq(true)
    end
  end

end
<<<<<<< HEAD

#object = mock()
#object.stubs(:stubbed_method_one).returns(:result_one)
#object.stubs(:stubbed_method_two).returns(:result_two)
=======
>>>>>>> master
