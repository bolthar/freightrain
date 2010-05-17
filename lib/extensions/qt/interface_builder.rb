
module Freightrain

  module Toolkit

    class InterfaceBuilder

      attr_reader :toplevel

      def initialize
        @builder = Qt::UiLoader.new
      end

      def file_found?(file_name)
        return get_ui_files(file_name)
      end

      def create_objects_from_file(file_name)
        file = Qt::File.new(get_ui_files(file_name))
        file.open(Qt::File::ReadOnly)
        @toplevel = @builder.load(file)
        file.close
        widgets = get_all_objects(@toplevel).select do |widget|
          widget.objectName && widget.objectName != ""
        end.map
        return widgets
      end

      def create_object_accessors(widgets, view)
        widgets.each do |widget|
          name = widget.objectName
          view.instance_eval "def #{name}; @widgets.select { |w| w.objectName == '#{name}'  }.first ;end;"
        end
      end

      def connect_to_callback(widget, event_name, method)
        begin
        decoy_class = Class.new(Qt::Widget)
        decoy_class.slots("#{widget.name}()")
        decoy_class.send(:define_method, widget.name) do |*args|
          method.call(*args)
        end
        decoy = decoy_class.new        
        widget.connect(SIGNAL(widget.get_event_signature(event_name)), decoy, widget.name.to_sym)
        rescue Exception => ex
#          p ex
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
