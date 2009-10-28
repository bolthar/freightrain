

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'rubygems'
require 'spec'
require 'mocha'
require 'needle'
require 'test/unit'
require 'freightrain/container_hookable.rb'
require 'freightrain/freight_view_model.rb'
require 'freightrain/string_patch.rb'

include Freightrain

Spec::Runner.configure do |config|
    config.mock_with :mocha
end

describe FreightViewModel do

  before :each do
    eval "class TestViewModel < FreightViewModel;end;"
  end

  after :each do
     #HACK: shouldn't be needed
    ContainerHookable.classes.clear #it avoids container specs to fail
  end

  it "should call container for correctly named view" do    
    view = stub()
    view.stubs(:signals).returns({})
    Freightrain.expects(:[]).with(:test_view).returns(view)
    TestViewModel.new
  end

  it "should call connect on each signal registered on view if correct method is present" do
    signal_one = mock()
    signal_one.expects(:connect)
    signal_two = mock()
    signal_two.expects(:connect)
    view = stub()
    view.stubs(:signals).returns({:test_one => signal_one, :test_two => signal_two})
    Freightrain.stubs(:[]).returns(view)
    TestViewModel.class_eval("def on_test_one;end;")
    TestViewModel.class_eval("def on_test_two;end;")
    TestViewModel.new
  end

  it "should not call connect on each signal registered on view if correct method is not present" do
    eval "class NoMethodsTestViewModel < FreightViewModel;end;"
    signal_one = mock()
    signal_one.expects(:connect).never
    signal_two = mock()
    signal_two.expects(:connect).never
    view = stub()
    view.stubs(:signals).returns({:test_one => signal_one, :test_two => signal_two})
    Freightrain.stubs(:[]).returns(view)
    NoMethodsTestViewModel.new
  end

  describe "show" do

    it "should always set view toplevel as visible" do
      toplevel = mock()
      toplevel.expects(:visible=).with(true)
      view = stub()
      view.stubs(:toplevel).returns(toplevel)
      view.stubs(:signals).returns({})
      Freightrain.stubs(:[]).returns(view)
      TestViewModel.new.show
    end

  end


end

