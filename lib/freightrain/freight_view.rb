
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

    def toplevel
      return @widgets.first.toplevel
    end  
    
    def initialize(builder = GtkExtensions::InterfaceBuilder.new)
      @builder = builder
      load_from_file(File.join(Freightrain.app_path,"views","#{self.class.name}"),@builder)
      create_signals
    end

  end

end
