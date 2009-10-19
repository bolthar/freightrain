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

  def test_ctor_viewParamProvided_callSignalsOnParam
    view = mock()
    view.expects(:signals).returns(stub(:each => nil))
    TestViewModel.new(view)
  end

  def test_ctor_viewParamNotProvided_initializeCorrectView
    require File.dirname(__FILE__) + '/views/VMTestView.rb'
    viewmodel = VMTestViewModel.new
    assert_equal VMTestView, viewmodel.get_view.class
  end

  def test_ctor_viewParamNotProvidedAndNoviewWithRightName_raise
    assert_raise NoMethodError do
      TestViewModel.new
    end
  end

  def test_ctor_signalOnViewButNoCallback_doNotCallConnect
    view = stub
    signal = mock
    signal.expects(:connect).never
    view.stubs(:signals).returns({:test => signal})
    TestViewModel.new(view)
  end

  def test_ctor_signalOnViewAndCallbackPresent_connectSignal
    view = stub
    signal = mock
    signal.expects(:connect)
    view.stubs(:signals).returns({:test => signal})
    TestViewModelSignal.new(view)
  end

end
