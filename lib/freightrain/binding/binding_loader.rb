
require 'yaml'

module Freightrain

  class BindingLoader
    
    def initialize(class_name)
      search_path = File.join(
        Freightrain.app_path,
        "views",
        Freightrain.toolkit.to_s,
        "**",
        class_name + ".bnd.yml")
      result = Dir.glob(search_path)
      @filename = result[0] if !result.empty?
    end

    def bind_widgets(widgets)
      if @filename
        bindings = YAML.load_file(@filename)
        p bindings
      end
    end


  end
end
