
module Freightrain
 
  class FreightBinding

    def initialze(widget, property)
      @widget =   widget
      @property = property
    end

    def to(path)
      @path = path
      return self
    end

    def update()
      @widget.send(@property + "=",@datasource.send(@path))
    end

  end

end
