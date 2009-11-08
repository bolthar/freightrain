
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FreightViewModel do

  before :each do
    @class = Class.new(FreightViewModel)
  end

  after :each do
     #HACK: shouldn't be needed
    ContainerHookable.classes.clear #it avoids container specs to fail
  end

  it "should always extend ContainerHookable" do
    @class.kind_of?(ContainerHookable).should == true
  end

  it "should always extend ServiceHost" do
    @class.kind_of?(ServiceHost).should == true
  end

  it "should always extend RegionHost" do
    @class.kind_of?(RegionHost).should == true
  end

  it "should always extend SignalHost" do
    @class.kind_of?(SignalHost).should == true
  end

  describe "ctor" do

    before :each do
      @view = stub(:signals => [], :data_source= => nil)
      Freightrain.stubs(:[]).returns(@view)
    end

    it "should call get services" do
      @class.send(:define_method, :get_services) do
        @called = true
      end
      instance = @class.new
      instance.instance_variable_get(:@called).should == true
    end

    it "should call build regions" do
      @class.send(:define_method, :build_regions) do
        @called = true
      end
      instance = @class.new
      instance.instance_variable_get(:@called).should == true
    end

    it "should call create signals" do
      @class.send(:define_method, :create_signals) do
        @called = true
      end
      instance = @class.new
      instance.instance_variable_get(:@called).should == true
    end
    
    it "should ask container for correct view" do
      @class.stubs(:name).returns("TestViewModel")
      Freightrain.expects(:[]).with(:test_view).returns(@view)
      @class.new
    end
    
    it "should connect to view's signal if correct method is defined" do
      @class.send(:define_method, :on_signal) do
        #do nothing
      end
      signal = mock(:connect)
      @view.stubs(:signals).returns({:signal => signal})
      @class.new
    end
    
    it "should not connect to view's signal if no correct method defined" do
      signal = mock()
      signal.expects(:connect).never
      @view.stubs(:signals).returns({:signal => signal})
      @class.new
    end
    
    it "should set view's datasource to self" do 
      @view.expects(:data_source=).with(kind_of(@class))
      @class.new
    end

    it "should connect to region's signal if correct method is defined" do
      @class.send(:define_method, :region_on_signal) do
        #do nothing
      end
      signal = mock(:connect)
      viewmodel = stub
      viewmodel.stubs(:signals).returns({:signal => signal})
      region = stub
      region.stubs(:viewmodel => viewmodel)
      @class.send(:define_method, :build_regions) do
        @regions = {:region => region}
      end      
      @class.new
    end

    it "should not connect to region's signal if no correct method defined" do
      signal = mock()
      signal.expects(:connect).never
      viewmodel = stub
      viewmodel.stubs(:signals).returns({:signal => signal})
      region = stub
      region.stubs(:viewmodel => viewmodel)
      @class.send(:define_method, :build_regions) do
        @regions = {:region => region}
      end
      @class.new
    end

  end


end
