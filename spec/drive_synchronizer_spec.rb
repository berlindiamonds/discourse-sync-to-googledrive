require 'spec_helper'
require './lib/drive_synchronizer.rb'
require 'mocha/test_unit'

describe DiscourseBackupToDrive::DriveSynchronizer do

  let(:b1) { Backup.new('backup1') }
  let(:b2) { Backup.new('backup2') }
  let(:b3) { Backup.new('backup3') }

  before do
    allow(Backup).to receive(:all).and_return([b1, b2, b3])
  end

	describe ".sync" do
    it "syncs itself" do
      should described_class.sync == true
    end
	end

  let ".upload" do
    expect {folder_name.add(file)}.to change {folder_name}.to_include(file)
  end
end


#it "shows cool things" do
 #     count = 1
 #    expect {
  #      count = 3
 #     }.to change { count }.by(2)

 #     expect {
        # not changing
 #     }.to_not change { count }

 #     count = 1
 #     expect {
  #      count = 3
  #    }.to change { count }.to(3)

  #    count = 1
   #   expect {
  #      count = 3
#}.to change { count }from(1).to(3)

#it "is pending when failing" do
   #   pending "This will be marked as pending when the block will fail, otherwise (on success) will fail telling 'Why am I pending if I pass?'" do
   #     1.should == 2 # will mark example as pending
   #     2.should == 2 # will fail asking to remove pending status of example
   #   end
#end
