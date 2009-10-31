
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FreightBinding do

  it "should raise if options parameter does not respond to indexer" do
      lambda do
        FreightBinding.new(nil, nil)
      end.should raise_error
    end

  describe "data source set" do   

    it "should wrap source param into a DataSourceShell" do
      source = :test
      binding = FreightBinding.new(:widget, {})
      DataSourceShell.expects(:new).with(source)
      binding.data_source = source
    end
    
  end

  describe "update" do

    it "should swallow exceptions silently" do
      binding = FreightBinding.new(:widget, {})
      binding.update #datasource not set, raises
    end

    it "should call set on widget with right params" do
      widget = mock()
      widget.expects(:set).with("property", :data_source_value)
      DataSourceShell.expects(:new).returns(widget)
      data_source = stub()
      data_source.stubs(:get).returns(:data_source_value)
      binding = FreightBinding.new(widget, {:property => :property})
      binding.instance_variable_set(:@data_source, data_source)
      binding.update
    end
    
    it "should call get on datasource with right params" do
      widget = stub()
      widget.stubs(:set)
      DataSourceShell.expects(:new).returns(widget)
      data_source = mock()
      data_source.expects(:get).with(["path"])
      binding = FreightBinding.new(widget, {:path => :path})
      binding.instance_variable_set(:@data_source, data_source)
      binding.update
    end

  end

  describe "commit" do


    it "should swallow exceptions silently" do
      binding = FreightBinding.new(:widget, {})
      binding.commit #datasource not set, raises
    end

    it "should call get on widget with right params" do
      widget = mock()
      widget.expects(:get).with("property")
      DataSourceShell.expects(:new).returns(widget)
      data_source = stub()
      data_source.stubs(:set)
      binding = FreightBinding.new(widget, {:property => :property})
      binding.instance_variable_set(:@data_source, data_source)
      binding.commit
    end

    it "should call set on datasource with right params" do
      widget = stub()
      widget.stubs(:get).returns(:value)
      DataSourceShell.expects(:new).returns(widget)
      data_source = mock()
      data_source.expects(:set).with(["path"], :value)
      binding = FreightBinding.new(widget, {:path => :path})
      binding.instance_variable_set(:@data_source, data_source)
      binding.commit
    end

  end
end

