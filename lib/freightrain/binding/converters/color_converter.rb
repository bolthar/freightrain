
module Freightrain
  class ColorConverter

    def from(val)
      return Freightrain::Color.rgb(val)
    end

    def to(val)
      return nil
    end

  end
end
