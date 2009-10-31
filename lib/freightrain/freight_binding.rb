
module Freightrain
 
  class FreightBinding

    def initialize(widget, options)
      @widget   = DataSourceShell.new(widget)
      @property = options[:property].to_s
      @path     = options[:path].to_s.split('.')
    end

    def data_source=(source)
      @data_source = DataSourceShell.new(source)
    end

    def update()
      begin
        @widget.set(@property, @data_source.get(@path))
      rescue Exception => ex
        p ex.message if @property == "property"
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
