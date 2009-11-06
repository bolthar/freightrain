
module Freightrain

  class Color

    def Color.rgb(rgb)
      value = rgb.to_s
      begin
        red = value[0..1].hex * 256
        green = value[2..3].hex * 256
        blue = value[4..5].hex * 256
        return Gdk::Color.new(red,green,blue)
      rescue
        raise ArgumentError("Could not create a color from #{value}")
      end
    end

  end

end

