
module Freightrain
  class ColorConverter

    def from(val)
      value = val.to_s
      red   = ((value[1..2].hex.to_i + 1) * 256) - 1
      green = ((value[3..4].hex.to_i + 1) * 256) - 1
      blue  = ((value[5..6].hex.to_i + 1) * 256) - 1
      return Gdk::Color.new(red,green,blue)
    end

    def to(val)
      return nil
    end

  end
end
