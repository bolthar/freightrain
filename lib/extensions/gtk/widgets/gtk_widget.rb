
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

    def color_from_rgb(string)
      red   = (string[0..1].hex) * 256
      green = (string[2..3].hex) * 256
      blue  = (string[4..5].hex) * 256
      return Gdk::Color.new(red, green, blue)
    end

    def background=(color)
      self.modify_bg(Gtk::STATE_NORMAL,color_from_rgb(color))
    end

    def foreground=(color)
      self.modify_fg(Gtk::STATE_NORMAL,color_from_rgb(color))
    end

    def base_background=(color)
      self.modify_fg(Gtk::STATE_NORMAL,color_from_rgb(color))
    end

    def plug_in(region_widget)
      self.remove(self.children.first) unless self.children.empty?
      self << region_widget
    end


  end


end