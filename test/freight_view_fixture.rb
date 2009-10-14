
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'freightrain/freight_view.rb'
require 'mocha'

include Freightrain

class DerivedTestView < FreightView

end

class FreightViewFixture < Test::Unit::TestCase

  def test_ctor_always_callLoadFromFile
    dirname = File.dirname(__FILE__)
    File.stubs(:dirname).returns(dirname)
    File.expects(:exists?).with(File.join(dirname,"DerivedTestView.glade"))
    DerivedTestView.new
  end

  def test_ctor_always_createHelperMethodOnView
    dirname = File.dirname(__FILE__)
    File.stubs(:dirname).returns(dirname)
    view = DerivedTestView.new
    assert view.respond_to? :vbox
  end
end
