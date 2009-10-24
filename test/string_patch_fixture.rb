
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'freightrain.rb'

include Freightrain

class StringPatchFixture < Test::Unit::TestCase

  def test_toConventionSym_noUppercaseLetters_returnSameString
    assert_equal :nouppercase, "nouppercase".to_convention_sym
  end

  def test_toConventionSym_firstLetterUppercase_returnStringWithFirstLetterDowncase
    assert_equal :firstletterupper, "Firstletterupper".to_convention_sym
  end

  def test_toConventionSym_uppercaseLetterMiddle_subWithUnderscoreAndLowercase
    assert_equal :in_between, "InBetween".to_convention_sym
  end


end
