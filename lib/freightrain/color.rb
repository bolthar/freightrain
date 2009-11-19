
module Freightrain

  class Color

    def Color.rgb(rgb)
      value = rgb.to_s
      red   = ((value[1..2].hex.to_i + 1) * 256) - 1
      green = ((value[3..4].hex.to_i + 1) * 256) - 1
      blue  = ((value[5..6].hex.to_i + 1) * 256) - 1
      return Gdk::Color.new(red,green,blue)
    end

  end

end

