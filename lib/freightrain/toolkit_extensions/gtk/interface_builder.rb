
module Freightrain

  module GtkExtensions

    class InterfaceBuilder

      def initialize
        @builder = Gtk::Builder.new
      end

      def file_found?(file_path)
        return File.exists?(file_path + ".glade")
      end

      def create_objects_from_file(file_path)
        @builder.add_from_file(file_path + ".glade")
        return @builder.objects.select do
          |obj| obj.respond_to?(:name) && obj.kind_of?(Gtk::Widget)
        end.map
      end

      def create_object_accessors(widgets, view)
        widgets.each do |widget|
          name = widget.name
          view.instance_eval "def #{name}; @widgets.select { |w| w.name == '#{name}'  }.first ;end;"
        end
      end

      def connect_signals()
        @builder.connect_signals do |signal|
          yield(signal)
        end
      end

    end

  end
end
