
require 'yaml'

module Freightrain

  class BindingLoader
    
    def initialize(class_name)
      search_path = File.join(
        Freightrain.views_path,
        "**",
        class_name.to_convention + ".bnd.yml")
      result = Dir.glob(search_path)
      @filename = result[0] if !result.empty?
    end

    def bind_widgets(widgets)
      return nil unless @filename
      binding_collection = YAML.load_file(@filename)
      binding_collection.each do |widget, binding|
        target  = widgets.select { |w| w.name == widget}.first
        #create array if there's only one binding
        binding = [binding_data] if binding.kind_of? Hash
        binding.each do |binding_options|
          binding_options.each do |key, value|
            options[key.to_sym] = value
          end
          target.bind(options) if target
        end
      end
    end


  end
end
