
module Freightrain

  class QtInterfaceBuilder

    def initialize
      @builder = Qt::UiLoader.new
    end

    def extension
      return "ui"
    end

    def toplevel
      return @toplevel
    end
    
    def add_from_file(file_path)
      file = Qt::File.new(file_path)
      file.open(Qt::File::ReadOnly)
      @toplevel = @builder.load(file)
      file.close
    end

    def objects
      return get_all_objects(@toplevel).select do |widget|
        widget.objectName && widget.objectName != ""
      end
    end

    def get_object(name)
      return objects.select { |widget| widget.objectName == name}.first
    end

    def get_widget_name(widget)
      return widget.objectName
    end

    def connect_signals
      @lightning_rod = Class.new(Qt::Widget)
      get_all_objects(@toplevel).select { |object| object.kind_of? Qt::Action}.each do |object|
        @lightning_rod.slots(object.objectName + "()")
        @lightning_rod.send(:define_method, object.objectName.to_sym) do
          yield("on_" + object.objectName).call
        end
      end
      @decoy = @lightning_rod.new
      get_all_objects(@toplevel).select { |object| object.kind_of? Qt::Action}.each do |object|
        Qt::Object.connect(object, SIGNAL('activated()'), @decoy, SLOT(object.objectName + "()"))
      end      
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
