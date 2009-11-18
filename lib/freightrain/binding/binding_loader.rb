
require 'yaml'

module Freightrain

  class BindingLoader
    
    def initialize(class_name)
      search_path = File.join(
        Freightrain.app_path,
        "views",
        Freightrain.toolkit.to_s,
        "**",
        class_name.to_convention + ".bnd.yml")
      result = Dir.glob(search_path)
      @filename = result[0] if !result.empty?
    end

    def bind_widgets(widgets)
      if @filename
        bindings = YAML.load_file(@filename)
        bindings.each do |widget, yaml_options|
          target = widgets.select { |w| w.name == widget}.first
          options = {}
          yaml_options.each do |key, value|
            options[key.to_sym] = value
          end
          target.bind(options)
        end
      end
    end


  end
end
