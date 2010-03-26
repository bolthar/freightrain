
module Freightrain

  class FreightView
    include InterfaceBuilder
    include BindingHost
    extend SignalHost
    extend ContainerHookable

#    attr_reader :widgets

    def widgets
      return @widgets.select { |widget| widget.kind_of? BindingBase }
    end

    def get_all_callbacks
      return self.methods.select do |method_name|
        method_name =~ /_on_/i
      end.map { |method_name| CallbackWrapper.new(method(method_name)) }
    end

    def self.container_options
      return {:model => :prototype}
    end

    def control
      return @builder.control
    end

    def toplevel
      return control.toplevel
    end

    def initialize()
      @widgets = []
      if(Freightrain.toolkit)
        self.class.instance_eval("include Toolkit::DialogHelper")
        @builder = Freightrain.get_interface_builder
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
