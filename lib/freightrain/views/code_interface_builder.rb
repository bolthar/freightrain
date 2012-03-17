
module Freightrain

  class CodeInterfaceBuilder

    def initialize
      @builder = Freightrain.get_interface_builder
    end

    def file_found?(file_name)
      return get_code_definition_file(file_name)
    end

    def create_objects_from_file(file_name)
      code_widgets = eval_script(file_found?(file_name))
      code_widgets.each do |k, v|
        v.builder_name = k.to_s
        v.show
      end #HACK - gtk only
      @widgets = code_widgets.values
      @builder.instance_variable_set(:@control, @widgets.first.toplevel) ##HACK: breaking toolkit agnostic
      return @widgets
    end
   
    def connect_to_callback(widget, event_name, method)
      @builder.connect_to_callback(widget, event_name, method)
    end
    
    def create_object_accessors(widgets, view) 
      @builder.create_object_accessors(widgets,view)
    end
    
    def control
      return @builder.control
    end

    private
    def get_code_definition_file(file_name)
      search_path = File.join(
        Freightrain.app_path,
        "views",
        "**",
        file_name.to_convention + ".rb.def")
      results = Dir.glob(search_path)
      return results.first
    end

    def eval_script(file_name) 
    widgets = {}
      eval(File.read(file_name), binding)
      return widgets
    end
    
  end  

end
