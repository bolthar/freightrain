
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InterfaceBuilder do
  
  describe "load from file" do

    before :each do
      File.stubs(:exists?).returns(true)
      @builder.stubs(:add_from_file)
      @builder.stubs(:objects).returns([])
      @builder.stubs(:connect_signals)
      @builder.stubs(:extension).returns("dmy")
      @class = Class.new()
      @class.instance_eval("include InterfaceBuilder")
    end

    it "should not create a view definition if file is not found" do
      File.stubs(:exists?).returns(false)
      @builder.expects(:add_from_file).never
      instance = @class.new
      instance.load_from_file("nofile", @builder)
    end

    it "should call add from file on builder if file is found" do
      File.stubs(:exists?).returns(true)
      @builder.expects(:add_from_file)
      instance = @class.new
      instance.load_from_file("yesfile", @builder)
    end

    it "should create an accessor method for every widget if widget responds to name" do
      File.stubs(:exists?).returns(true)
      widget_one = stub(:name => "my_name_one")
      widget_two = stub(:name => "my_name_two")
      @builder.stubs(:objects).returns([widget_one, widget_two])
      instance = @class.new
      instance.load_from_file("dummy", @builder)
      instance.respond_to?(:my_name_one).should == true
      instance.respond_to?(:my_name_two).should == true
    end

    it "should attach correct handler to widget if method is present" do
      @class.send(:define_method, :on_widget_clicked) { }
      @builder.stubs(:connect_signals).yields("on_widget_clicked")      
      instance = @class.new
      instance.expects(:method).with("on_widget_clicked")
      instance.load_from_file("dummy", @builder)
    end


    
  end

end

