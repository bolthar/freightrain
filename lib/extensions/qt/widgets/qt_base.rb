
module Qt

  class Base
    include Freightrain::BindingBase

    def plug_in(region_widget)
      region_widget.setParent(self)
      region_widget.show
    end

    def name
      return self.objectName
    end

    def signals
      return {}
    end

    def get_event_signature(event_name)
      return signals[event_name.to_sym] || "#{event_name}()"
    end
    
    def foreground=(val)
      palette = self.palette
      palette.setColor(Qt::Palette.Foreground, Qt::Color.new(val[0], val[1], val[2]))
      self.palette = palette
    end

    def background=(val)
      palette = self.palette
      palette.setColor(Qt::Palette.Background, Qt::Color.new(val[0], val[1], val[2]))
      self.palette = palette
    end

    
  end

end

