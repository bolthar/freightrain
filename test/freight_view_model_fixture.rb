# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'freightrain.rb'
require 'mocha'

include Freightrain

class TestViewModel < FreightViewModel


end

class TestViewModelSignal < FreightViewModel

  def on_test()

  end

end

class VMTestViewModel < FreightViewModel

  def get_view
    return @view
  end
  
end

class FreightViewModelFixture < Test::Unit::TestCase

  def test_ctor_always_fetchViewFromFreightrain
    view = mock()
    view.stubs(:signals).returns(stub(:each => nil))
    Freightrain.expects(:[]).with(:test_view).returns(view)
    TestViewModel.new()
  end


  def test_ctor_noViewWithRightName_bubbleException
    Freightrain.expects(:[]).with(:test_view).raises(Exception)
    assert_raise Exception do
      TestViewModel.new
    end
  end

  def test_ctor_signalOnViewButNoCallback_doNotCallConnect
    view = stub
    signal = mock
    signal.expects(:connect).never
    view.stubs(:signals).returns({:test => signal})
    Freightrain.expects(:[]).with(:test_view).returns(view)
    TestViewModel.new()
  end

  def test_ctor_signalOnViewAndCallbackPresent_connectSignal
    view = stub
    signal = mock
    signal.expects(:connect)
    view.stubs(:signals).returns({:test => signal})
    Freightrain.expects(:[]).with(:test_view_signal).returns(view)
    TestViewModelSignal.new()
  end

  def test_show_always_setVisibletrueOnViewToplevel
    view = stub
    toplevel = mock
    toplevel.expects(:visible=).with(true)
    view.stubs(:toplevel).returns(toplevel)
    view.stubs(:signals).returns([])
    Freightrain.expects(:[]).with(:test_view).returns(view)
    TestViewModel.new().show
  end

end
