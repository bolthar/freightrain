
module Freightrain

  class DataSourceShell

    def initialize(data_source)
      @data_source = data_source
    end

    def get(path)
      return @data_source.send(path[0]) if path.length == 1
      target = path.shift
      get(path,@data_source.send(target))
    end

    def set(path, value)
      return @data_source.send(path[0].to_s + "=",value) if path.length == 1
      target = path.shift
      set(path, @data_source.send(target), value)
    end

  end
end