require 'libglade2'

module Freightrain
  module GtkBuilderHelper

    def load_from_file(file_path)
      if File.exists?(file_path)
        @builder = Gtk::Builder.new
        @builder.add_from_file(file_path)
        @builder.objects.each do |widget|
          instance_eval "def #{widget.name}; return @builder.get_object('#{widget.name}');end"
        end
        @builder.connect_signals do |handler|
          if self.respond_to? :handler
            return method(handler)
          end
        end
      end
    end

  end
end