
module Qt

  class Base

    def bind(binding_options)
      @bindings ||= {}
      binding = FreightBinding.new(self, binding_options)
      #TODO: send out warning on override?
      @bindings[binding_options[:property]] = binding
      return binding
    end

    def bindings
      @bindings ||= {}
      return @bindings.values
    end
    
  end

end

