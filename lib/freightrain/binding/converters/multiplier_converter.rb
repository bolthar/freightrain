# To change this template, choose Tools | Templates
# and open the template in the editor.

module Freightrain

  class MultiplierConverter
    def initialize(factor)
      @factor = factor
    end

    def from(value)
      return value * @factor
    end
  end
end
