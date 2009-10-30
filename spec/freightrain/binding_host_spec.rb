
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BindingHost do

  before :each do    
    klass = Class.new
    klass.instance_eval("include BindingHost")
    @instance = klass.new    
  end

  describe "data source =" do

    before :each do
      @binding_one = stub()
      @binding_two = stub()
      @instance.stubs(:bindings).returns([@binding_one, @binding_two])
    end

    it "should set data source assigned param on each binding" do
      data_source = :test
      @binding_one.expects(:data_source=).with(data_source)
      @binding_one.stubs(:update)
      @binding_two.expects(:data_source=).with(data_source)
      @binding_two.stubs(:update)
      @instance.data_source = data_source
    end

    it "should call update on each binding" do
      @binding_one.stubs(:data_source=)
      @binding_one.expects(:update)
      @binding_two.stubs(:data_source=)
      @binding_two.expects(:update)
      @instance.data_source = :dummy
    end

  end

  describe "bindings" do

    it "should return all the bindings on the widgets" do
      widget_one = stub(:bindings => [:b1])
      widget_two = stub(:bindings => [:b2])
      @instance.stubs(:widgets).returns([widget_one, widget_two])
      @instance.bindings.length.should == 2
      @instance.bindings.include?(:b1).should == true
      @instance.bindings.include?(:b2).should == true
    end

    it "should return a flat array" do
      widget_one = stub(:bindings => [:b1])
      widget_two = stub(:bindings => [:b2,:b3])
      @instance.stubs(:widgets).returns([widget_one, widget_two])
      @instance.bindings.length.should == 3
      @instance.bindings.include?(:b1).should == true
      @instance.bindings.include?(:b2).should == true
      @instance.bindings.include?(:b3).should == true
    end

  end

  describe "commit" do

    it "should call commit on each binding" do
      binding_one = mock(:commit)
      binding_two = mock(:commit)
      @instance.stubs(:bindings).returns([binding_one, binding_two])
      @instance.commit
    end

  end

  describe "update" do

    it "should call update on each binding" do
      binding_one = mock(:update)
      binding_two = mock(:update)
      @instance.stubs(:bindings).returns([binding_one, binding_two])
      @instance.update
    end

  end
 
end

