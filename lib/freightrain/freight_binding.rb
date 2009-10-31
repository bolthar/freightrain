
module Freightrain
 
  class FreightBinding

    def initialize(widget, options)
      @widget    = widget
      @property  = options[:property].to_s.split('.')
      @path      = options[:path].to_s.split('.')
      @converter = options[:converter]
    end

    def get(source, path)
      return source.send(path[0]) if path.length == 1
      target = path.shift
      get(source.send(target), path)
    end

    def set(path, value, source)
      return source.send(path[0].to_s + "=",value) if path.length == 1
      target = path.shift
      set(path, value, source.send(target))
    end

    def data_source=(source)
      @data_source = source
    end

    def update()
      begin
        if @converter
          set(@property, @converter.from(get(@data_source, @path)), @widget)
        else
          set(@property, get(@data_source, @path), @widget)
        end
      rescue Exception => ex
        p "#{@widget.name}: #{ex.message}"
      end
    end

    def commit()
      begin
        @data_source.set(@path, @widget.get(@property))
      rescue Exception => ex
        p ex.message
      end
    end
    
  end

end
