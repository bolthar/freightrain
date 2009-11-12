
module Freightrain

  module GtkExtensions

    class InterfaceBuilder

      def initialize
        @gtk_builder = Gtk::Builder.new
      end

      def file_found?(file_path)
        return File.exists?(file_path + ".glade")
      end

      def create_objects_from_file(file_path)
        @gtk_builder.add_from_file(file_path + ".glade")
        return @gtk_builder.objects.select do
          |obj| obj.respond_to?(:name) && obj.kind_of?(Gtk::Widget)
        end.map
      end

      def create_object_accessors(widgets, view)
        widgets.each do |widget|
          name = widget.name
          view.instance_eval "def #{widget.name}; @widgets.select { |w| w.name == '#{name}'  }.first ;end;"
        end
      end

      def connect_signals()
        @gtk_builder.connect_signals do |signal|
          yield(signal)
        end
      end

#      def objects
#        return @gtk_builder.objects.select do |widget|
#          widget.respond_to?(:name) && widget.kind_of?(Gtk::Widget)
#        end
#      end

#      def get_widget_name(widget)
#        return widget.name
#      end
#
      
#
#      def get_object(name)
#        return @builder.get_object(name)
#      end
#
#      def connect_signals
#        raise "You must provide a block to connect_signals" unless block_given?
#        @builder.connect_signals do |signal|
#          yield(signal)
#        end
#      end

    end

  end
end
