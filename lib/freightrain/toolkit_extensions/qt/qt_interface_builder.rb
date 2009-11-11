
module Freightrain

  class QtInterfaceBuilder

    def initialize
      @builder = Qt::UiLoader.new
    end
    
    def add_from_file(file_path)
      file = Qt::File.new(file_path)
      file.open(Qt::File::ReadOnly)
      @toplevel = @builder.load(file)
      file.close
    end

    def objects
      return get_all_objects(@toplevel)      
    end

    def get_object(name)
      return get_all_objects(@toplevel).select { |widget| widget.objectName == name}.first
    end

    def connect_signals
      p "not yet implemented"
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
