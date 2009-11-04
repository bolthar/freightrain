
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe FreightBinding do

  it "should raise if options parameter does not respond to indexer" do
      lambda do
        FreightBinding.new(nil, nil)
      end.should raise_error
    end

  describe "data source" do

    it "should return data source if element source is nil" do
      binding = FreightBinding.new(:widget, {})
      binding.instance_variable_set(:@data_source, :value)
      binding.data_source.should == :value
    end

    it "should return element source if element source is not nil" do
      binding = FreightBinding.new(:widget, {})
      binding.instance_variable_set(:@data_source, :no_good)
      binding.instance_variable_set(:@element_source, :value)
      binding.data_source.should == :value
    end

  end

  describe "data source =" do

    it "should always set data source variable" do
      binding = FreightBinding.new(:widget, {})
      binding.data_source = :value
      binding.instance_variable_get(:@data_source).should == :value
    end

  end

  describe "update" do

    it "should swallow exceptions silently" do
      binding = FreightBinding.new(:widget, {})
      binding.update #datasource not set, raises
    end

    it "should set property on widget if value is different from cache" do
      widget = mock()
      widget.expects(:test=).with(:value)
      datasource = stub()
      datasource.stubs(:my_path).returns(:value)
      options = {:property => :test, :path => :my_path}
      binding = FreightBinding.new(widget, options)
      binding.instance_variable_set(:@data_source, datasource)
      binding.update
    end
    
    it "should set property on widget if force is true" do
      widget = mock()
      widget.expects(:test=).with(:value)
      datasource = stub()
      datasource.stubs(:my_path).returns(:value)
      options = {:property => :test, :path => :my_path, :force => true}
      binding = FreightBinding.new(widget, options)
      binding.instance_variable_set(:@cache, :value)
      binding.instance_variable_set(:@data_source, datasource)
      binding.update
    end

    it "should not set property on widget if value is equal to cache" do
      widget = mock()
      widget.expects(:test=).with(:value).never
      datasource = stub()
      datasource.stubs(:my_path).returns(:value)
      options = {:property => :test, :path => :my_path}
      binding = FreightBinding.new(widget, options)
      binding.instance_variable_set(:@cache, :value)
      binding.instance_variable_set(:@data_source, datasource)
      binding.update
    end

    it "should set cache to value if property on widget is set" do
      widget = mock()
      widget.stubs(:test=).with(:value)
      datasource = stub()
      datasource.stubs(:my_path).returns(:value)
      options = {:property => :test, :path => :my_path, :force => true}
      binding = FreightBinding.new(widget, options)
      binding.instance_variable_set(:@cache, :value)
      binding.instance_variable_set(:@data_source, datasource)
      binding.update
      binding.instance_variable_get(:@cache).should == :value
    end

    it "should call from on converter if widget property is to set" do
      widget = mock()
      widget.stubs(:test=).with(:value)
      datasource = stub()
      datasource.stubs(:my_path).returns(:value)
      options = {:property => :test, :path => :my_path, :force => true, :converter => mock(:from)}
      binding = FreightBinding.new(widget, options)
      binding.instance_variable_set(:@data_source, datasource)
      binding.update
    end

  end

  describe "commit" do


    it "should swallow exceptions silently" do
      binding = FreightBinding.new(:widget, {})
      binding.commit #datasource not set, raises
    end

    it "should call converter to" do
      widget = stub()
      widget.stubs(:my_prop).returns(:value)
      options = {:property => :my_prop, :path => :my_path , :converter => mock(:to)}
      binding = FreightBinding.new(widget, options)
      binding.commit
    end

    it "should call set on datasource with right params" do
      widget = stub()
      widget.stubs(:my_prop).returns(:value)
      datasource = mock()
      datasource.expects(:my_path=).with(:value)
      options = {:property => :my_prop, :path => :my_path}
      binding = FreightBinding.new(widget, options)
      binding.instance_variable_set(:@data_source, datasource)
      binding.commit
    end

  end
end

