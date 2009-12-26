
module Freightrain

  class FreightView
    include InterfaceBuilder
    include BindingHost
    extend SignalHost
    extend ContainerHookable

   
    def self.container_options
      return {:model => :prototype}
    end

    def self.wrap_container(widget)
      return Toolkit::RegionContainer.new(widget)
    end

    def widgets
      return @widgets
    end

    def control
      return @builder.control
    end

    def toplevel
      return control.toplevel
    end

    def initialize()
      @widgets = []
      if defined?(Freightrain::Toolkit)
        self.class.instance_eval("include Toolkit::DialogHelper")
        @builder = Toolkit::InterfaceBuilder.new
        load_from_file(self.class.name, @builder)
      end
      hook_to_layout_widgets()
      load_bindings_from_file(@widgets)
      create_signals
    end

    def hook_to_layout_widgets
      @widgets.select{ |widget| widget.is_a? LayoutWidget }.each do |widget|
        method_prefix = widget.name + "_on_"
        self.methods.select { |method_name| method_name =~ /#{method_prefix}/}.each do |method_name|
          signal_name = method_name.sub(method_prefix, "")
          widget.add_signal_callback(signal_name.to_sym, method(method_name))
        end
      end
    end

  end

end
