
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe AutoStubber do

  describe "stub signals" do

    before :each do
      @class = stub_everything
      @class.stubs(:instance_variable_get).with(:@signals).returns({})
      @host  = stub_everything
      @host.stubs(:class).returns(@class)
    end

    it "should create an omni stub for each signal defined" do
      auto_stubber = AutoStubber.new
      auto_stubber.expects(:stub_everything).times(2)
      @class.stubs(:instance_variable_get).with(:@signals).returns({'a' => 1, 'b' => 2})
      auto_stubber.stub_signals(@host)
    end

    it "should set signal host's signals as the omni stubs hash" do
      auto_stubber = AutoStubber.new
      auto_stubber.stubs(:stub_everything).returns("bla")
      @class.stubs(:instance_variable_get).with(:@signals).returns({'a' => 1, 'b' => 2})
      @host.expects(:instance_variable_set).with(:@signals, has_key("b"))
      auto_stubber.stub_signals(@host)
    end
    
    it "should always define a 'should fire' method" do
      auto_stubber = AutoStubber.new
      auto_stubber.stubs(:stub_everything)
      @class.expects(:send).with(:define_method, :should_fire)
      auto_stubber.stub_signals(@host)
    end

  end
end