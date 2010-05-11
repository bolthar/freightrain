
module Freightrain

  module BindingHost

    def load_bindings_from_file(widgets)      
      loader = BindingLoader.new(self.class.name)      
      loader.each_binding do |widget_name, options|
        widget = widgets.select { |widget| widget.name == widget_name }.first
        widget.bind(options) if widget
      end
    end
    
    def data_source=(source)
      bindings.each do |binding|
        binding.data_source = source
        binding.update #TODO: is this necessary?
      end
    end
    
    def bindings
      return widgets.each.map { |widget| widget.bindings }.flatten
    end

    def commit
      bindings.each { |binding| binding.commit }
    end

    def update
      bindings.each { |binding| binding.update }
    end

  end
  
end