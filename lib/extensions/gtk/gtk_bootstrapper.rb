
#TODO: use require all
#TODO: use File.join for god's sake!

require 'libglade2'
require File.dirname(__FILE__) + "/binding_base.rb"
require File.dirname(__FILE__) + "/widgets/gtk_image.rb"
require File.dirname(__FILE__) + "/widgets/gtk_toggle_button.rb"
require File.dirname(__FILE__) + "/widgets/gtk_toggle_tool_button.rb"
require File.dirname(__FILE__) + "/widgets/gtk_widget.rb"
require File.dirname(__FILE__) + "/widgets/gtk_combo_box.rb"
require File.dirname(__FILE__) + "/widgets/gtk_calendar.rb"
require File.dirname(__FILE__) + "/widgets/gtk_treeview.rb"
require File.dirname(__FILE__) + "/widgets/gtk_treeviewcolumn.rb"
require File.dirname(__FILE__) + "/widgets/gtk_layout.rb"
require File.dirname(__FILE__) + "/widgets/gtk_statusicon.rb"
require File.dirname(__FILE__) + "/interface_builder.rb"
require File.dirname(__FILE__) + "/dialog_helper.rb"

module Freightrain
  
  module Toolkit

    def self.start_main_loop
      yield
      Gtk.main
    end

    def self.quit
      Gtk.main_quit
    end

  end

end