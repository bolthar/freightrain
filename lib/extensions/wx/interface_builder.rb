
module Freightrain
  module Toolkit

    class InterfaceBuilder

      attr_reader :toplevel
      
      def file_found?(file_name)
        return get_xrc_files(file_name)
      end
      
      def get_xrc_files(file_name)
        search_path = File.join(
          Freightrain.app_path,
          "views",
          "**",
          file_name.to_convention + ".xrc")
        results = Dir.glob(search_path)
        return results.first
      end

      def create_objects_from_file(file_name)
        builder = Wx::XmlResource.new(get_xrc_files(file_name))
        toplevel_name = get_toplevel_name(file_name)
        @toplevel = builder.load_frame(nil, toplevel_name)
        return get_all_objects(@toplevel)
      end

      def create_object_accessors(widgets, view)
        widgets.each do |widget|
          view.instance_eval "def #{name}; @widgets.select { |w| w.name == '#{widget.name}'  }.first ;end;"
        end
      end

      def connect_to_callback(widget, event_name, callback)
#        widget.connect(SIGNAL(widget.get_event_signature(event_name))) do |*args|
#          callback.call(*args)
#        end
      end

      def control
        return @toplevel
      end

      private
      def get_all_objects(parent, objects = [])
        objects << parent
        parent.get_children.each do |child|
          get_all_objects(child, objects)
        end
        return objects
      end

      def get_toplevel_name(file_name)
        return "my_frame"
      end

    end
    
  end
end