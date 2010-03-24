
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InterfaceBuilder do
  
  describe "load from file" do

    before :each do
      klass = Class.new
      klass.instance_eval("include InterfaceBuilder")
      @instance = klass.new
      @builder = stub()
      @builder.stubs(:file_found?).returns(true)
      @builder.stubs(:create_objects_from_file)
      @builder.stubs(:create_object_accessors)
      @builder.stubs(:connect_signals)
    end

    it "should do nothing if file is not found" do
      @instance.load_from_file(:nofile, stub(:file_found? => false))
    end
    
    it "should call create_objects_from_file if file found" do
      @builder.expects(:create_objects_from_file).with(:filename)      
      @instance.load_from_file(:filename, @builder)
    end

    it "should call create_object_accessors with widgets if file found" do
      @builder.stubs(:create_objects_from_file).returns(:widgets)
      @builder.expects(:create_object_accessors).with(:widgets, @instance)
      @instance.load_from_file(:filename, @builder)
    end

    it "should call connect_signals if file found" do
      @builder.expects(:connect_signals)
      @instance.load_from_file(:filename, @builder)
    end   
    
  end

end

