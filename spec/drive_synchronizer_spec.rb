<<<<<<< HEAD
require 'rails_helper'

describe ::DiscourseBackupToDrive::DriveSynchronizer do

=======
require './lib/synchronizer.rb'
describe ::DiscourseBackupToDrive::Synchronizer::DriveSynchronizer do
  
>>>>>>> ad7a6f05a99a332643dbc04170c9cfa36a15a1ed
  let(:backup) { Backup.new('backup') }

  describe "#backup" do
    it "has a reader method for the backup" do
      ds = described_class.new(backup)
      expect(ds.backup).to eq(backup)
    end
  end


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
