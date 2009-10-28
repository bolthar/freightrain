
module Gtk

  class Widget

    def bind(property)
      return FreightBinding.new(self, property)
    end

  end


end