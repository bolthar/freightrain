
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe FreightElementView do

  before :each do
    Freightrain.app_path = "dummy"
  end

  it "should always have a 'selected' signal" do
    klass = Class.new(FreightElementView)
    instance = klass.new
    instance.signals[:selected].should be_a_kind_of(FreightSignal)
  end

  it "should always extend ContainerHookable" do
    klass = Class.new(FreightElementView)
    klass.is_a?(ContainerHookable).should == true
  end

  describe "self.ContainerOptions" do 
    
    it "should always be a prototype model" do 
      klass = Class.new(FreightElementView)
      klass.container_options[:model].should == :prototype
    end

  end

  describe "set_ui_selection" do

    before :each do
      Freightrain.app_path = "dummy"
      klass = Class.new(FreightElementView)
      klass.signal(:signal_one)
      klass.signal(:signal_two)
      @instance = klass.new
    end

    it "should always stifle all signals" do
      signal_one = stub()
      signal_one.expects(:stifle)
      signal_one.stubs(:unleash)
      signal_two = stub()
      signal_two.expects(:stifle)
      signal_two.stubs(:unleash)
      @instance.signals[:signal_one] = signal_one
      @instance.signals[:signal_two] = signal_two
      @instance.set_ui_selection(nil)
    end

    it "should always call selected with param" do
      value = mock(:called => nil)
      @instance.class.class_eval do
        def selected(value)
          value.called
        end
      end
      @instance.set_ui_selection(value)
    end

    it "should always unleash all signals" do
      signal_one = stub()
      signal_one.stubs(:stifle)
      signal_one.expects(:unleash)
      signal_two = stub()
      signal_two.stubs(:stifle)
      signal_two.expects(:unleash)
      @instance.signals[:signal_one] = signal_one
      @instance.signals[:signal_two] = signal_two
      @instance.set_ui_selection(nil)
    end

    it "should always call selected when all signal stifled" do
      value = mock(:called => nil)
      @instance.signals[:signal_one].connect(lambda {raise "laame!"})
      @instance.signals[:signal_two].connect(lambda {raise "not cool!"})
      @instance.class.class_eval do
        def selected(value)
          fire :signal_one
          fire :signal_two
          value.called
        end
      end
      @instance.set_ui_selection(value)      
    end

  end


end

