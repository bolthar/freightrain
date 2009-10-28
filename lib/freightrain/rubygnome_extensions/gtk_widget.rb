
module Gtk

  class Widget

    def bind(property)
      @bindings ||= {}
      binding = FreightBinding.new(self, property)
      @bindings[property] = binding
      return binding
    end

    def bindings
      return @bindings.values
    end

  end


end