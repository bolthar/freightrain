
module Freightrain

  class FreightView
    include InterfaceBuilder
    include DialogHelper
    include BindingHost
    extend SignalHost
    extend ContainerHookable

    attr_reader :widgets

    def self.container_options
      return {:model => :prototype}
    end

    def self.wrap_container(widget)
      if Freightrain.toolkit == :qt
        return QtExtensions::RegionContainer.new(widget)
      else
        return GtkExtensions::RegionContainer.new(widget)
      end
    end

    def toplevel
      if Freightrain.toolkit == :qt
        @builder.toplevel
      else
        @widgets.first.toplevel
      end
    end

    def initialize()
      @widgets = []
      if Freightrain.toolkit == :qt
        @builder = QtExtensions::InterfaceBuilder.new
      else
        @builder = GtkExtensions::InterfaceBuilder.new
      end
      load_from_file(self.class.name, @builder)
      create_signals
    end

  end

end
