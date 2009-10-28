
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FreightView do

  before :each do
    eval "class TestView < FreightView;end;"
    File.stubs(:join).returns("nofile")
  end

  after :each do 
    #HACK: shouldn't be needed
    ContainerHookable.classes.clear #it avoids container specs to fail
  end

  it "should always call load_from_file with right params" do
    #TODO: assert on load_from_file, not just on File.exists?
    File.expects(:exists?).with("nofile")
    TestView.new
  end

  it "should add a signal for each signal registered" do
    TestView.signal(:first)
    TestView.signal(:second)
    view = TestView.new
    view.signals.length.should == 2
    view.signals.include?(:first).should == true
    view.signals.include?(:second).should == true
    TestView.instance_variable_set(:@signals,[]) #cleaning up
  end

  it "should add no signal if no signals registered" do
    view = TestView.new
    view.signals.length.should == 0
  end

  it "should not add the same signal twice" do
    TestView.signal(:clone)
    TestView.signal(:clone)
    view = TestView.new
    view.signals.length.should == 1
    TestView.instance_variable_set(:@signals,[]) #cleaning up
  end

  describe "toplevel" do

    it "should always return first object's toplevel" do
      builder = stub()
      builder.stubs(:objects).returns(
        stub(:first => stub(
          :toplevel => :correct)))
      view = TestView.new(builder)
      view.toplevel.should == :correct
    end

  end

  describe "fire" do

    it "should raise if called with non existing signal" do
      view = TestView.new
      lambda do
        view.fire :no_signal
      end.should raise_error
    end

    it "should call fire on signal if existing" do
      signal = mock(:fire)
      view = TestView.new
      view.instance_variable_set(:@signals, {:my_signal => signal})
      view.fire :my_signal
    end

    it "should call fire on signal with right arguments" do
      signal = mock()
      signal.expects(:fire).with(:a, :b)
      view = TestView.new
      view.instance_variable_set(:@signals, {:my_signal => signal})
      view.fire :my_signal, :a, :b
    end
  end




end

