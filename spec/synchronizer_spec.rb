describe Synchronizer do

  class TestSynchronizer < Synchronizer
    def initialize(can_sync)
      @can_sync = can_sync
      @performed = false
    end

    def can_sync?
      @can_sync
    end

    def perform_sync
      @performed = true
    end

    def performed?
      @performed
    end
  end

  describe "#perform" do
    
     it "performs when can_sync returns true" do
        ts = TestSynchronizer.new(true)
        ts.sync
        expect(ts.performed?).to eq(true)
     end

     it "doesn't perform when can_sync returns true" do
        ts = TestSynchronizer.new(false)
        ts.sync
        expect(ts.performed?).to eq(false)
     end
  end
  
end