require File.dirname(__FILE__) + "/gtk_builder_helper.rb"

module Freightrain

  class FreightView
    include GtkBuilderHelper
    include DialogHelper
    include BindingHost
    extend SignalHost
    extend ContainerHookable

    container_options[:model] = :prototype

    def self.container_options
      return {:model => :prototype}
    end

    def toplevel
      return @builder.objects.first.toplevel
    end

    def widgets
      return @builder.objects.select { |widget| widget.kind_of? Gtk::Widget }
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
