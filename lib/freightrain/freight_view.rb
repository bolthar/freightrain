
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
      return Toolkit::RegionContainer.new(widget)
    end

    def toplevel
      return @builder.toplevel
    end

    def initialize()
      @widgets = []
      @builder = Toolkit::InterfaceBuilder.new
      load_from_file(self.class.name, @builder)
      create_signals
    end

  end

end
