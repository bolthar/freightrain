# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'freightrain.rb'
require 'mocha'

include Freightrain

class TestViewModel < FreightViewModel


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
    assert_raise NameError do 
      VMTestViewModel.new
    end
  end
end
