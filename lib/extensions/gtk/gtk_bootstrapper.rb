
require 'libglade2'
require File.dirname(__FILE__) + "/widgets/gtk_image.rb"
require File.dirname(__FILE__) + "/widgets/gtk_widget.rb"
require File.dirname(__FILE__) + "/widgets/gtk_treeview.rb"
require File.dirname(__FILE__) + "/widgets/gtk_treeviewcolumn.rb"
require File.dirname(__FILE__) + "/widgets/gtk_layout.rb"
require File.dirname(__FILE__) + "/interface_builder.rb"
require File.dirname(__FILE__) + "/region_container.rb"
require File.dirname(__FILE__) + "/dialog_helper.rb"

module Freightrain
  
  module Toolkit

    def self.start_main_loop
      yield
      Gtk.main
    end

  end

end