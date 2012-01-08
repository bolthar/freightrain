
module Gtk

  class Widget
    include Freightrain::BindingBase

    def defaults
      @defaults = {} unless @defaults
      return @defaults
    end
    
    #made for easier compatibility (other toolkits use show/hide)
    def show
      self.visible = true
    end

    def hide
      self.visible = false
    end

    def name
      return self.builder_name
    end

    def color_from_rgb(rgb_array)    
      return nil unless rgb_array.kind_of? Enumerable
      red   = rgb_array[0] * 255
      green = rgb_array[1] * 255
      blue  = rgb_array[2] * 255
      return Gdk::Color.new(red, green, blue)
    end

    def get_color(symbol_or_array)
      if symbol_or_array.kind_of? Symbol
        rgb_array = FreightColor[symbol_or_array]
      else
        rgb_array = symbol_or_array
      end
      return color_from_rgb(rgb_array)
    end

    def background=(color)
      self.modify_bg(Gtk::STATE_NORMAL, get_color(color))
    end

    def foreground=(color)
      self.modify_fg(Gtk::STATE_NORMAL, get_color(color))
    end

    def base_background=(color)
      self.modify_base(Gtk::STATE_NORMAL, get_color(color))
    end

    def plug_in(region_widget)
      self.remove(self.children.first) unless self.children.empty?
      self << region_widget
    end

  end

end
