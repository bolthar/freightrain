
module Freightrain

  module Toolkit

    class InterfaceBuilder

      def initialize
        @builder = Gtk::Builder.new
      end

      def file_found?(file_name)
        return get_glade_file(file_name)
      end

      def create_objects_from_file(file_name)
        @builder.add_from_file(get_glade_file(file_name))
        if @builder.objects.first.respond_to? :toplevel
          @control = @builder.objects.first.toplevel
        end
        return @builder.objects.select do |obj|
          obj.respond_to? :name
        end
      end

      def create_object_accessors(widgets, view)
        widgets.select { |widget| widget.respond_to? :name }.each do |widget|
          name = widget.name
          view.instance_eval "def #{name}; @widgets.select { |w| w.name == '#{name}'  }.first ;end;"
        end
      end

#      def connect_signals()
#        @builder.connect_signals do |signal|
#          yield(signal)
#        end
#      end

      def connect_to_callback(widget, event_name, method)
        widget.signal_connect(event_name) do |instance, *args|
          method.call(*args)
        end
      end

      def get_glade_file(file_name)
        search_path = File.join(
          Freightrain.app_path,
          "views",
          "**",
          file_name.to_convention + ".glade")
        results = Dir.glob(search_path)
        return results.first
      end

      def control
        return @control
      end

    end

  end
end
