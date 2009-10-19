# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'freightrain.rb'

include Freightrain

class SignalFixture < Test::Unit::TestCase

  def test_fire_noProcSet_doNotThrow
    signal = FreightSignal.new
    signal.fire
  end

  def test_fire_procSet_callProcWithArgs
    signal = FreightSignal.new
    value = nil
    signal.connect proc {|arg| value = arg }
    signal.fire "test"
    assert_equal "test",value
  end

  def test_fire_procSetOnceAndThenAnotherTime_callLastProcSet
    signal = FreightSignal.new
    value = nil
    signal.connect proc { value = "not good" }
    signal.connect proc { value = "okay" }
    signal.fire
    assert_equal "okay", value
  end
end
