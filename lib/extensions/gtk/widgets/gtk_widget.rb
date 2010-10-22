
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

    def color_from_rgb(rgb_array)    
      return nil unless rgb_array.kind_of? Enumerable
      red   = rgb_array[0] * 255
      green = rgb_array[1] * 255
      blue  = rgb_array[2] * 255
      return Gdk::Color.new(red, green, blue)
    end

    def name
      return self.builder_name
    end

    def background=(color)      
      self.modify_bg(Gtk::STATE_NORMAL, color_from_rgb(color))
    end

    def foreground=(color)
      self.modify_fg(Gtk::STATE_NORMAL, color_from_rgb(color))
    end

    def base_background=(color)
      self.modify_base(Gtk::STATE_NORMAL, color_from_rgb(color))
    end

    def plug_in(region_widget)
      self.remove(self.children.first) unless self.children.empty?
      self << region_widget
    end


  end


end