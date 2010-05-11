
require 'yaml'

module Freightrain

  class BindingLoader
    
    def initialize(class_name)      
      @search_path = File.join(
        Freightrain.views_path,
        "**",
        class_name.to_convention + ".bnd.yml")      
    end

    def filename
      result = Dir.glob(@search_path)
      return result[0] || nil
    end

    #TODO: refactor, this needs a little cleanup, method does too much
    def each_binding
      return nil unless filename
      binding_collection = YAML.load_file(filename) || []
      binding_collection.each do |widget, binding|
        binding = [binding] if binding.kind_of? Hash #needed if only 1 binding declared
        binding.each do |binding_options|
          options = {}
          binding_options.each do |key, value|
            options[key.to_sym] = value
          end
          yield(widget, options)
        end        
      end
    end

  end
end
