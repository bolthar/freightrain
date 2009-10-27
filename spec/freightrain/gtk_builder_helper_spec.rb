
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GtkBuilderHelper do
  
  describe "load from file" do

    before :each do
      File.stubs(:exists?).with("gladefile").returns(true)
      @filename = "gladefile"
      @extender = stub()
      @extender.class.instance_eval("include GtkBuilderHelper")
      @builder = stub()
      @builder.stubs(:add_from_file)
      @builder.stubs(:objects).returns([])
      @builder.stubs(:connect_signals)
    end
    
    it "should raise if definition file is not present" do 
      lambda do
        @extender.load_from_file("nofile")
      end.should raise_error
    end
    
    it "should call add_from_file on builder with filename" do      
      @builder.expects(:add_from_file).with(@filename)
      @extender.load_from_file(@filename, @builder)
    end

    #TODO: change this spec so it verifies calls to instance_eval instead
    it "should create an instance accessor method for each object in builder" do
      objects = [
        mock(:name => "widget_one"),
        mock(:name => "widget_two")
        ]
      @builder.stubs(:objects).returns(objects)
      @extender.load_from_file(@filename, @builder)
    end
    
    it "should connect signal with method having same name if present" do
      signal_name = "my_signal"
      @builder.stubs(:connect_signals).yields(signal_name)
      @extender.instance_eval("def #{signal_name};end;")
      @extender.stubs(:respond_to?).with(signal_name).returns(true)
      @extender.expects(:method).with(signal_name)
      @extender.load_from_file(@filename, @builder)
    end

    it "should connect to tracing lambda if no method with same name present" do
      signal_name = "no_method_signal"
      @builder.stubs(:connect_signals).yields(signal_name)
      @extender.expects(:respond_to?).with(signal_name).returns(false)
      @extender.expects(:method).with(signal_name).never
      @extender.load_from_file(@filename, @builder)
    end
  end

end

