
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
          target = @widgets.select { |widget| callback.matches_widget?(widget)}.first
          builder.connect_to_callback(target, callback.event_name(target), callback.method) if target
        end
      end
    end

  end
end