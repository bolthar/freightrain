
module Freightrain
  module InterfaceBuilder

    def load_from_file(file_path,builder = GtkInterfaceBuilder.new)
      definition_file_path = file_path + "." + builder.extension
      if File.exists?(definition_file_path)
        builder.add_from_file(definition_file_path)
        builder.objects.each do |widget|
          method_name = builder.get_widget_name(widget)
          instance_eval "def #{method_name}; return @builder.get_object('#{method_name}');end;"
        end
        builder.connect_signals do |handler|
          if self.respond_to? handler
            method(handler)
          end
        end
      end
    end

  end
end