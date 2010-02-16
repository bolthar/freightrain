
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe FreightElementView do

  before :each do
    Freightrain.app_path = "dummy"
  end

  it "should always have a 'selected' signal" do
    klass = Class.new(FreightElementView)
    p Freightrain.toolkit
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

  #TODO: complete spec coverage
  describe "update" do

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
      @instance.update
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
      @instance.update
    end  

  end


end

