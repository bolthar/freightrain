
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe FreightView do

  before :each do
    @class = Class.new(FreightView)
    File.stubs(:join).returns("nofile")
    Freightrain.toolkit = :test
    Freightrain.stubs(:get_interface_builder).returns(stub(:file_found? => false))
    @class.stubs(:instance_eval)
  end

  after :each do 
    #HACK: shouldn't be needed
    ContainerHookable.classes.clear #it avoids container specs to fail
    Freightrain.toolkit = nil
  end

  it "should always include BindingHost" do
    @class.included_modules.include?(BindingHost).should == true
  end

  it "should always include InterfaceBuilder" do
    @class.included_modules.include?(InterfaceBuilder).should == true
  end

  it "should always extend SignalHost" do
    @class.kind_of?(SignalHost).should == true
  end

  it "should always extend ContainerHookable" do
    @class.kind_of?(ContainerHookable).should == true
  end

  describe "container options" do

    it "should always return an hash with model == prototype" do
      @class.container_options[:model].should == :prototype
    end

  end
  
  describe "ctor" do

    it "should include Toolkit::DialogHelper if toolkit defined" do
      @class.stubs(:name).returns("myname")
      @class.expects(:instance_eval).with("include Toolkit::DialogHelper")
      @class.new()
    end

    it "should call load_from_file with right params if toolkit defined" do
      @class.stubs(:name).returns("myname")      
      Freightrain.stubs(:get_interface_builder).returns(:builder)
      @class.send(:define_method, :load_from_file) do |path, builder|
        @called = true if (path == "myname" && builder == :builder)
      end
      @class.new().instance_variable_get(:@called).should == true
    end

    it "should always call create_signals" do
      @class.send(:define_method, :create_signals) do
        @called = true
      end
      @class.new.instance_variable_get(:@called).should == true
    end

  end  

end

