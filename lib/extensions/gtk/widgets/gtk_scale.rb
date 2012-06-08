
module Gtk

  class Scale

    def created_callback
      self.adjustment = Adjustment.new(0,0,100,5,10,10) if self.adjustment.lower == self.adjustment.upper
    end

  end

end
