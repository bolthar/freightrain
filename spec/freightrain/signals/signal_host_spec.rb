
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe SignalHost do

  before :each do
    @class = Class.new()
    @class.instance_eval("extend SignalHost")
  end

  describe "signal" do

    it "should create variable when first called" do
      @class.instance_variable_get(:@signals).should == nil
      @class.signal(:signal)
      @class.instance_variable_get(:@signals).should_not == nil
    end

    it "should add one signal each time it is called" do
      @class.signal(:signal)
      @class.signal(:another)
      @class.signal(:signal) # to check that same signals are still added
      @class.instance_variable_get(:@signals).length.should == 3
    end
    
  end
  
  describe "create signals" do

    it "should add a signal for each signal registered" do
      @class.instance_variable_set(:@signals, [:first, :second])
      instance = @class.new
      instance.send(:create_signals)
      instance.signals.length.should == 2
      instance.signals.include?(:first).should == true
      instance.signals.include?(:second).should == true
    end

    it "should add no signal if no signals registered" do
      instance = @class.new
      instance.send(:create_signals)
      instance.signals.length.should == 0      
    end

    it "should not add the same signal twice" do
      @class.instance_variable_set(:@signals, [:clone, :clone])
      instance = @class.new
      instance.send(:create_signals)
      instance.signals.length.should == 1
    end

  end

  describe "fire" do

    it "should raise if called with non existing signal" do
      instance = @class.new
      lambda do
        instance.fire :no_signal
      end.should raise_error
    end

    it "should call fire on signal if existing" do
      signal = mock(:fire)
      instance = @class.new
      instance.instance_variable_set(:@signals, {:my_signal => signal})
      instance.fire :my_signal
    end

    it "should call fire on signal with right arguments" do
      signal = mock()
      signal.expects(:fire).with(:a, :b)
      instance = @class.new
      instance.instance_variable_set(:@signals, {:my_signal => signal})
      instance.fire :my_signal, :a, :b
    end

  end

end

