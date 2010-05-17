
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
        @lightning_rod = Class.new(Qt::Widget)
        @lightning_rod.slots("1" + event_name.name + "()")
        @lightning_rod.send(:define_method, "1" + event_name.name) do
#          arguments = [instance, *args].first(method.arity.abs)
          method.call
        end
        decoy = @lightning_rod.new
        widget.connect(SIGNAL("#{event_name}()"), decoy, SLOT(widget.name))
        rescue Exception => ex
          #TODO:handle this
        end
      end

      def connect_signals()
        @lightning_rod = Class.new(Qt::Widget)
        actions = get_all_objects(@toplevel).select { |action| action.kind_of? Qt::Action}
        actions.each do |action|
          @lightning_rod.slots("1" + action.objectName + "()")
          @lightning_rod.send(:define_method, "1" + action.objectName) do
            callback = yield("on_" + action.objectName)
            callback.call if callback
          end
        end
        decoy = @lightning_rod.new
        actions.each do |action|
#          Qt::Object.connect(action, SIGNAL('activated()'), decoy, SLOT("action.objectName" + "()"))
          action.connect(SIGNAL('activated()'), decoy, SLOT(action.objectName))
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

      def toplevel
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
