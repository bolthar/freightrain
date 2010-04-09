
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

  describe "stub regions" do

    before :each do
      @class = stub_everything
      @class.stubs(:instance_variable_get).with(:@regions).returns({})
      @host  = stub_everything
      @host.stubs(:class).returns(@class)
    end

    it "should create an omni stub for each region defined" do
      auto_stubber = AutoStubber.new
      auto_stubber.expects(:stub_everything).times(2)
      @class.stubs(:instance_variable_get).with(:@regions).returns({'r1' => 1, 'r2' => 2})
      auto_stubber.stub_regions(@host)
    end

    it "should create a method on host for each region defined" do
      auto_stubber = AutoStubber.new
      @class.stubs(:instance_variable_get).with(:@regions).returns({'r1' => 1, 'r2' => 2})
      @class.expects(:define_method).with('r1')
      @class.expects(:define_method).with('r2')
      auto_stubber.stub_regions(@host)      
    end

    it "should set region host's regions as the omni stubs hash" do
      auto_stubber = AutoStubber.new
      auto_stubber.stubs(:stub_everything).returns("bla")
      @class.stubs(:instance_variable_get).with(:@regions).returns({'a' => 1, 'b' => 2})
      @host.expects(:instance_variable_set).with(:@regions, has_key('b'))
      auto_stubber.stub_regions(@host)
    end

    it "should always define a 'should change region' method" do
      auto_stubber = AutoStubber.new
      auto_stubber.stubs(:stub_everything)
      @class.expects(:send).with(:define_method, :should_change_region)
      auto_stubber.stub_regions(@host)
    end

  end

  describe "stub services" do

    before :each do
      @class = stub_everything
      @class.stubs(:instance_variable_get).with(:@services).returns({})
      @host  = stub_everything
      @host.stubs(:class).returns(@class)
    end

    it "should create an omni stub for each service defined" do
      auto_stubber = AutoStubber.new
      auto_stubber.expects(:stub_everything).times(2)
      @class.stubs(:instance_variable_get).with(:@services).returns({'s1' => 1, 's2' => 2})
      auto_stubber.stub_services(@host)
    end

    it "should call instance_variable_set on host for each service defined" do
      auto_stubber = AutoStubber.new
      auto_stubber.stubs(:stub_everything)
      @host.expects(:instance_variable_set).with("@s1", anything)
      @host.expects(:instance_variable_set).with("@s2", anything)
      @class.stubs(:instance_variable_get).with(:@services).returns({'s1' => 1, 's2' => 2})
      auto_stubber.stub_services(@host)
    end

    it "should create a method on host for each service defined" do
      auto_stubber = AutoStubber.new
      @class.stubs(:instance_variable_get).with(:@services).returns({'s1' => 1, 's2' => 2})
      @class.expects(:define_method).with('s1')
      @class.expects(:define_method).with('s2')
      auto_stubber.stub_services(@host)
    end

  end

  describe "stub_view" do

    it "should call instance_variable_set with right params" do
       auto_stubber = AutoStubber.new
       auto_stubber.stubs(:stub_everything).returns(1)
       viewmodel = stub()
       viewmodel.expects(:instance_variable_set).with(:@view, 1)
       auto_stubber.stub_view(viewmodel)
    end

    it "should create an accessor method for view" do
       auto_stubber = AutoStubber.new
       auto_stubber.stubs(:stub_everything)
       viewmodel = stub()
       viewmodel.stubs(:class).returns(mock(:define_method))
       auto_stubber.stub_view(viewmodel)
       viewmodel.view
    end

  end

  describe "stub_viewmodel" do

    before :each do
      @stubber  = AutoStubber.new
      @class    = stub_everything
      @class.stubs(:@services).returns({})
      @class.stubs(:@regions).returns({})
      @class.stubs(:@signals).returns({})
      @instance = stub_everything
      @instance.stubs(:class).returns(@class)
      Freightrain.stubs(:[]).with(:test_view_model).returns(@instance)
    end

    it "should ask Freightrain for the right element" do
      Freightrain.expects(:[]).with(:test_view_model).returns(@instance)
      @stubber.stub_viewmodel(:test)
    end

    it "should always override bootstrap" do
      @class.expects(:define_method).with(:bootstrap)
      @stubber.stub_viewmodel(:test)
    end

    it "should call stub_signals" do
      @stubber.expects(:stub_signals)
      @stubber.stub_viewmodel(:test)
    end

    it "should call stub_services" do
      @stubber.expects(:stub_services)
      @stubber.stub_viewmodel(:test)
    end

    it "should call stub_regions" do
      @stubber.expects(:stub_regions)
      @stubber.stub_viewmodel(:test)
    end

    it "should call stub_view" do
      @stubber.expects(:stub_view)
      @stubber.stub_viewmodel(:test)
    end

  end

  describe "stub service" do

    before :each do
      @stubber  = AutoStubber.new
      @class    = stub_everything
      @class.stubs(:@services).returns({})
      @class.stubs(:@signals).returns({})
      @instance = stub_everything
      @instance.stubs(:class).returns(@class)
      Freightrain.stubs(:[]).with(:test_service).returns(@instance)
    end

    it "should ask Freightrain for the right element" do
      Freightrain.expects(:[]).with(:test_service).returns(@instance)
      @stubber.stub_service(:test)
    end

    it "should call stub_signals" do
      @stubber.expects(:stub_signals)
      @stubber.stub_service(:test)
    end

    it "should call stub_services" do
      @stubber.expects(:stub_services)
      @stubber.stub_service(:test)
    end
    
  end

end