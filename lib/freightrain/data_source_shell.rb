
module Freightrain

  class DataSourceShell

    def initialize(data_source)
      @data_source = data_source
    end

    def get(path, source = @data_source)
      return source.send(path[0]) if path.length == 1
      target = path.shift
      get(path,source.send(target))
    end

    def set(path, value, source = @data_source)
      return source.send(path[0].to_s + "=",value) if path.length == 1
      target = path.shift
      set(path, value, source.send(target))
    end

  end
  
end