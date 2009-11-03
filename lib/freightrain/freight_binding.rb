
module Freightrain

  class DefaultConverter

    def from(value)
      return value
    end

  end
 
  class FreightBinding

    def initialize(widget, options)
      @widget    = widget
      @property  = options[:property].to_s.split('.')
      @path      = options[:path].to_s.split('.')
      @converter = options[:converter] || DefaultConverter.new
      @force     = options[:force]
    end

    def get(source, path)
      my_path = path.clone
      return source.send(my_path[0]) if my_path.length == 1
      target = my_path.shift
      get(source.send(target), my_path)
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
        value = get(@data_source, @path)
        if @force || value != @cache
          set(@property, @converter.from(value), @widget)
          if value.kind_of? Enumerable
            @cache = value.clone
          else
            @cache = value
          end
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
