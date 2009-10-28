
module Gtk

  class Widget

    def bind(property)
      FreightBinding.new(self, property)
    end

  end


end