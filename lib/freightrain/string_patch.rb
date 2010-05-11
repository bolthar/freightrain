
class String

  #TODO: maybe activesupport has something like this
  def to_convention
    return "" if self.empty?
    clone = self.clone
    first_letter = clone.slice!(0)
    result = first_letter.chr.downcase
    #fix, each_char seems not to be implemented
    #before 1.8.7
    (0...clone.length).each do |index|
      letter = clone[index].chr
      if letter =~ /^[A-Z]/
        result += "_"
        result += letter.downcase
      else
        result += letter
      end
    end
    return result.downcase
  end

  def to_convention_sym
    return nil if self.to_convention.empty?
    return self.to_convention.to_sym
  end

  def from_convention
    return self.capitalize.gsub(/_./) { |s| s.delete("_").capitalize }
  end
end
