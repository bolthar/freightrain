
module Freightrain

  def get_interface_builder
    return Toolkit::InterfaceBuilder.new    
  end
  
  module InterfaceBuilder

    def load_from_file(file_name, builder)
      if builder.file_found?(file_name)
        @widgets = builder.create_objects_from_file(file_name)
        builder.create_object_accessors(@widgets, self)
        self.get_all_callbacks.each do |callback|
          target = @widgets.select { |widget| callback.target == widget.name }.first
          builder.connect_to_callback(target, callback.event, callback.method) if target
        end
      end
    end

  end
end
