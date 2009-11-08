
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FreightView do

  before :each do
    @class = Class.new(FreightView)
    File.stubs(:join).returns("nofile")
  end

  after :each do 
    #HACK: shouldn't be needed
    ContainerHookable.classes.clear #it avoids container specs to fail
  end

  it "should always include BindingHost" do
    @class.included_modules.include?(BindingHost).should == true
  end

  it "should always include DialogHelper" do
    @class.included_modules.include?(DialogHelper).should == true
  end

  it "should always include GtkBuilderHelper" do
    @class.included_modules.include?(GtkBuilderHelper).should == true
  end

  it "should always extend SignalHost" do
    @class.kind_of?(SignalHost).should == true
  end

  it "should always extend ContainerHookable" do
    @class.kind_of?(ContainerHookable).should == true
  end

  describe "ctor" do

    before :each do
      @class.send(:define_method, :called) do
        return @called
      end
    end

    it "should always call load_from_file with right params" do
      @class.stubs(:name).returns("myname")
      File.stubs(:join).with(anything, "views", "myname.glade").returns(:correct)
      @class.send(:define_method, :load_from_file) do |path, builder|
        @called = true if (path == :correct && builder == :builder)
      end
      @class.new(:builder).called.should == true
    end

    it "should always call create_signals" do
      @class.send(:define_method, :create_signals) do
        @called = true
      end
      @class.new.called.should == true
    end

  end
  
  describe "container options" do

    it "should always return an hash with model == prototype" do
      @class.container_options[:model].should == :prototype
    end

  end

  describe "toplevel" do

    it "should always return first object's toplevel" do
      builder = stub()
      builder.stubs(:objects).returns(
        stub(:first => stub(
          :toplevel => :correct)))
      view = @class.new(builder)
      view.toplevel.should == :correct
    end

  end

  describe "widgets" do

    it "should return all objects in builder who derive from Gtk::Widget" do
      builder = stub()
      builder.stubs(:objects).returns([
          stub(:kind_of? => Gtk::Widget),
          nil,
          nil])
      view = @class.new(builder)
      view.widgets.length.should == 1
    end

 end

  

 




end

