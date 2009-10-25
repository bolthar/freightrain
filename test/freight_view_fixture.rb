
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'freightrain.rb'
require 'mocha'

include Freightrain

class DerivedTestView < FreightView

end

class SignalsTestView < FreightView

  signal :test_one
  signal :test_two

end

class FreightViewFixture < Test::Unit::TestCase

  def setup
    Freightrain.APP_PATH = File.dirname(__FILE__)
  end

  def test_include_always_GtkBuilderHelper
    view = DerivedTestView.new
    assert view.kind_of? GtkBuilderHelper
  end

  def test_include_always_DialogHelper
    view = DerivedTestView.new
    assert view.kind_of? DialogHelper
  end

  def test_ctor_always_callLoadFromFile
    dirname = File.dirname(__FILE__)
    File.stubs(:dirname).returns(dirname)
    File.expects(:exists?).with(File.join(dirname,"views", "DerivedTestView.glade"))
    DerivedTestView.new
  end

  def test_ctor_always_createHelperMethodOnView
    dirname = File.dirname(__FILE__)
    File.stubs(:dirname).returns(dirname)
    view = DerivedTestView.new
    assert view.respond_to? :vbox
  end

  def test_toplevel_testview_returnWindow
    dirname = File.dirname(__FILE__)
    File.stubs(:dirname).returns(dirname)
    view = DerivedTestView.new
    assert_equal view.toplevel, view.window
  end

  def test_selfSignal_always_addSignalsOnCtor
    view = SignalsTestView.new
    assert_equal 2,view.signals.length 
  end

  def test_selfSignal_always_addOnlyMySignals
    view = DerivedTestView.new
    assert_equal 0,view.signals.length
  end



end
