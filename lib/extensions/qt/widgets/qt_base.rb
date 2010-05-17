
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
    
  end

end

