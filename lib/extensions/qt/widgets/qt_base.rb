
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
    
  end

end

