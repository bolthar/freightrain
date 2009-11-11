
module Freightrain

  class FreightView
    include InterfaceBuilder
    include DialogHelper
    include BindingHost
    extend SignalHost
    extend ContainerHookable

    def self.container_options
      return {:model => :prototype}
    end

    def toplevel
      return @builder.toplevel
    end

    def widgets
      return @builder.objects
    end   
    
    def initialize(builder = GtkInterfaceBuilder.new)
      @builder = builder
      load_from_file(File.join(Freightrain.app_path,"views","#{self.class.name}"),@builder)
      create_signals
    end

  end

end
