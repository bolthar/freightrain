
module Freightrain

  class FreightView
    include GtkBuilderHelper

    def initialize
      load_from_file(File.join(File.dirname(__FILE__), "#{self.class.name}.glade"))
    end

  end

end
