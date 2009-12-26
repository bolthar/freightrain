
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe FreightRegion do

  describe "viewmodel" do

    before :each do      
      Freightrain.stubs(:[]).with(:custom_view_model).returns(2)
      Freightrain.stubs(:[]).with(:test_view_model).returns(1)
    end
    
    it "should return viewmodel corresponding to the region's name if not specified" do 
      region = FreightRegion.new(:test, {})
      region.viewmodel.should == 1      
    end
    
    it "should return options[:viewmodel] 's viewmodel if present" do
      region = FreightRegion.new(:test, {:viewmodel => :custom})
      region.viewmodel.should == 2
    end
    
  end

  describe "on show" do

    it "should always call view for container" do
      Freightrain.stubs(:[]).with(:test_view_model).returns(stub(:show))
      view = stub()
      view.expects(:send).with('test_region').returns(stub(:plug_in))
      region = FreightRegion.new(:test, {})
      region.on_show(view)
    end

    it "should always call plug in on container with viewmodel.show's result" do
      viewmodel = stub()
      viewmodel.stubs(:show).returns(1)
      container = mock()
      container.expects(:plug_in).with(1)
      Freightrain.stubs(:[]).with(:test_view_model).returns(viewmodel)
      view = stub()
      view.stubs(:send).with('test_region').returns(container)
      region = FreightRegion.new(:test, {})
      region.on_show(view)
    end

  end

  describe "connect to" do

    it "should not connect signal if method is not present on host" do
      signal = mock()
      signal.expects(:connect).never
      viewmodel = stub()
      viewmodel.stubs(:signals).returns({:signal => signal})
      Freightrain.stubs(:[]).with(:test_view_model).returns(viewmodel)
      region = FreightRegion.new(:test, {})
      region.connect_to(nil)
    end

    it "should connect to signal if method is present on host" do
      signal = mock()
      signal.expects(:connect).with(1)
      viewmodel = stub()
      viewmodel.stubs(:signals).returns({:signal => signal})
      host = stub()
      host.stubs(:respond_to?).with(:test_on_signal).returns(true)
      host.stubs(:method).returns(1)
      Freightrain.stubs(:[]).with(:test_view_model).returns(viewmodel)
      region = FreightRegion.new(:test, {})
      region.connect_to(host)
    end
    
  end

end

