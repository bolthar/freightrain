
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
          p callback.target, callback.event, callback.method
          target = @widgets.select { |widget| callback.target == widget.name }.first
          p @widgets
          p target
          builder.connect_to_callback(target, callback.event, callback.method) if target
        end
      end
    end

  end
end
