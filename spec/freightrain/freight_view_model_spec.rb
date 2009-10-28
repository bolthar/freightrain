
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FreightViewModel do

  it "should call container for correctly named view" do
    eval "class TestViewModel < FreightViewModel;end;"
    view = stub()
    view.stubs(:signals).returns({})
    Freightrain.expects(:[]).with(:test_view).returns(view)
    TestViewModel.new
  end

  it "should call connect on each signal registered on view if correct method is present" do
    eval "class TestViewModel < FreightViewModel;end;"
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
      eval "class TestViewModel < FreightViewModel;end;"
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

