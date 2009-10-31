
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Gtk::Widget do

  before :each do
    klass = Class.new(Gtk::Widget)
    klass.class_eval("def initialize;end;")
    @widget = klass.new
  end

  describe "bind" do

    it "should call FreightBinding.new with right params" do
      options = {:property => :test}
      FreightBinding.expects(:new).with(@widget,options)
      @widget.bind(options)
    end

    it "should add binding to bindings" do
      options = {:property => :test}
      FreightBinding.stubs(:new)
      binding = @widget.bind(options)
      @widget.instance_variable_get(:@bindings)[:test].should == binding
    end

    it "should override old binding if set twice" do
      options = {:property => :test}
      FreightBinding.stubs(:new)
      binding_one = @widget.bind(options)
      binding_two = @widget.bind(options)
      @widget.instance_variable_get(:@bindings)[:test].should != binding_one
      @widget.instance_variable_get(:@bindings)[:test].should == binding_two
    end

  end

  describe "bindings" do

    it "should return an empty array if no bindings set" do      
      @widget.bindings.should == []
    end

    it "should return an array with all binding values" do
      @widget.bind({:property => 1})
      @widget.bind({:property => 2})
      @widget.bindings.length.should == 2
    end
    
  end
end

