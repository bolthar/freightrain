
module Gtk

  class Widget

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

    def background=(color)
      self.modify_bg(Gtk::STATE_NORMAL, Freightrain::Color.rgb(color)) if color.kind_of? String
      self.modify_bg(Gtk::STATE_NORMAL, color) if color.kind_of? Gdk::Color
    end

  end


end