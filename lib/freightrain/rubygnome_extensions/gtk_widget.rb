
module Gtk

  class Widget

    def bind(binding_options)
      @bindings ||= {}
      binding = FreightBinding.new(self, binding_options)
      #TODO: send out warning if overriding?
      @bindings[binding_options[:property]] = binding
      return binding
    end

    def bindings
      @bindings ||= {}
      return @bindings.values
    end

  end


end