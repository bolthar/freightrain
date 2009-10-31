require File.dirname(__FILE__) + "/gtk_builder_helper.rb"

module Freightrain
  

  class FreightView
    include GtkBuilderHelper
    include DialogHelper
    include BindingHost
    extend ContainerHookable
    
    def toplevel
      return @builder.objects.first.toplevel
    end

    def widgets
      return @builder.objects.select { |widget| widget.kind_of? Gtk::Widget }
    end
    
    def self.signal(signal_name)
      @signals ||= []
      @signals << signal_name.to_sym
    end

    def fire(signal, *args)
      @signals[signal.to_sym].fire(*args)
    end

    def signals()
      return @signals
    end

    def initialize(builder = Gtk::Builder.new)
      @builder = builder
      load_from_file(File.join(Freightrain.app_path,"views","#{self.class.name}.glade"),@builder)
      @signals = {}
      signals = self.class.instance_variable_get(:@signals)
      signals ||= []
      signals.each do |signal|
        @signals[signal] = FreightSignal.new
      end
    end

  end

end
