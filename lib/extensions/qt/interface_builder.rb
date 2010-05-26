
module Freightrain

  module Toolkit

    class InterfaceBuilder

      attr_reader :toplevel

      def file_found?(file_name)
        return get_ui_files(file_name)
      end

      def create_objects_from_file(file_name)
        file = Qt::File.new(get_ui_files(file_name))
        file.open(Qt::File::ReadOnly)
        builder = Qt::UiLoader.new
        @toplevel = builder.load(file)
        builder.dispose
        file.close
        return get_all_objects(@toplevel).select do |widget|
          widget.objectName && widget.objectName != ""
        end
      end

      def create_object_accessors(widgets, view)
        widgets.each do |widget|
          name = widget.objectName
          view.instance_eval "def #{name}; @widgets.select { |w| w.objectName == '#{name}'  }.first ;end;"
        end
      end

      def connect_to_callback(widget, event_name, callback)
        widget.connect(SIGNAL(widget.get_event_signature(event_name))) do |*args|
          callback.call(*args)
        end
      end

      def get_ui_files(file_name)
        search_path = File.join(
          Freightrain.app_path,
          "views",
          "**",
          file_name.to_convention + ".ui")
        results = Dir.glob(search_path)
        return results.first
      end

      def control
        return @toplevel
      end

      private
      def get_all_objects(parent, objects = [])
        objects << parent
        parent.children.each do |child|
          get_all_objects(child, objects)
        end
        return objects
      end

    end

  end
end
