require File.dirname(__FILE__) + "/gtk_builder_helper.rb"

module Freightrain

  class FreightView
    include GtkBuilderHelper
    include DialogHelper

    def toplevel
      return @builder.objects.select { |widget| widget.kind_of? Gtk::Window}[0]
    end

    def initialize
      load_from_file(File.join(Freightrain.APP_PATH,"views","#{self.class.name}.glade"))
    end

  end

end
