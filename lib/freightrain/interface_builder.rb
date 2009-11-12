
module Freightrain
  module InterfaceBuilder

    def load_from_file(file_path,builder = GtkInterfaceBuilder.new)
      if builder.file_found?(file_path)
        @widgets = builder.create_objects_from_file(file_path)
        builder.create_object_accessors(@widgets, self)
        builder.connect_signals do |signal|
          if self.respond_to? signal
            method(signal)
          end
        end
      end
    end

  end
end