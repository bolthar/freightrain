
require 'rubygems'

class String

  def to_convention_sym
    #TODO: use regexp instead
    return nil if self.empty?
    clone = self
    first_letter = clone.slice!(0)
    result = first_letter.chr.downcase
    clone.each_char do |letter|
      if letter =~ /^[A-Z]/
        result += "_"
        result += letter.downcase
      else
        result += letter
      end
    end
    return result.downcase.to_sym
  end
end
