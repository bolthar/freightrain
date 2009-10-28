
module Freightrain
 
  class FreightBinding

    def initialize(widget, property)
      @widget =   widget
      @property = property
    end

    def data_source=(source)
      @data_source = source
    end

    def to(path)
      @path = path
      return self
    end

    def update()
      @widget.send(@property.to_s + "=",@data_source.send(@path))
    end

    def commit()
      @data_source.send(@path.to_s + "=",@widget.send(@property))
    end

  end

end
