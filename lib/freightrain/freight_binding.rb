
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
      new_path = @path.to_s.split('.')
      source_value = get_source_value(new_path, @data_source)
      @widget.send(@property.to_s + "=",source_value)
    end

    def commit()
      set_source_value(@path.to_s.split('.'), @data_source, @widget.send(@property))
#      @data_source.send(@path.to_s + "=",@widget.send(@property))
    end

    def get_source_value(path, source)
      return source.send(path[0]) if path.length == 1
      target = path.shift
      get_source_value(path,source.send(target))
    end

    def set_source_value(path, source, value)
      return source.send(path[0].to_s + "=",value) if path.length == 1
      target = path.shift
      set_source_value(path, source.send(target), value)
    end

  end

end
