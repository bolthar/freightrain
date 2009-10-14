require File.dirname(__FILE__) + "/gtk_builder_helper.rb"

module Freightrain

  class FreightView
    include GtkBuilderHelper

    def initialize
      load_from_file(File.join(Freightrain.APP_PATH,"views","#{self.class.name}.glade"))
    end

  end

end
