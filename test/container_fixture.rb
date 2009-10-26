
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'freightrain.rb'
require 'mocha'

include Freightrain

class ContainerFixture < Test::Unit::TestCase

  def test_configurecontainer_always_registerAllViews
    FreightView.expects(:subclasses).returns([Object])
    FreightViewModel.stubs(:subclasses).returns(nil)
    FreightService.stubs(:subclasses).returns(nil)
    Freightrain.configure_container!
    assert Freightrain[:object].kind_of? Object
  end

  def test_configurecontainer_always_askFreightViewModelForSublclasses
    FreightView.stubs(:subclasses).returns(nil)
    FreightViewModel.expects(:subclasses).returns([Object])
    FreightService.stubs(:subclasses).returns(nil)
    Freightrain.configure_container!
    assert Freightrain[:object].kind_of? Object
  end

  def test_configurecontainer_always_askFreightServiceForSublclasses
    FreightView.stubs(:subclasses).returns(nil)
    FreightViewModel.stubs(:subclasses).returns(nil)
    FreightService.expects(:subclasses).returns([Object])
    Freightrain.configure_container!
    assert Freightrain[:object].kind_of? Object
  end

  def test_indexer_servicenotregistered_raise
    assert_raise Needle::ServiceNotFound do
      Freightrain[:Nonregistered]
    end
  end
  


end
