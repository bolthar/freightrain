
module Freightrain
  module GtkBuilderHelper

    def load_from_file(file_path,builder = Gtk::Builder.new)
      if File.exists?(file_path)
        builder.add_from_file(file_path)
        builder.objects.each do |widget|
          if widget.respond_to? :name
            method_name = widget.name
            instance_eval "def #{method_name}; return @builder.get_object('#{method_name}');end"
          end
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