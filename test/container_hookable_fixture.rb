

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'freightrain.rb'

include Freightrain

class TestHookable 
  extend ContainerHookable

end

class A < TestHookable
end

class B < TestHookable
end

class ContainerHookableFixture < Test::Unit::TestCase

  def test_oninherit_always_addClassToSubclasses
    assert_equal 2, TestHookable.subclasses.length
    assert TestHookable.subclasses.include? A
    assert TestHookable.subclasses.include? B
  end

  def test_subclasses_always_presentOnExtendingClasses
    assert TestHookable.respond_to? :subclasses
  end
end
