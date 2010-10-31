
#TODO: use require all

require 'gtk2'
require File.join(File.dirname(__FILE__), "widgets/gtk_image.rb")
require File.join(File.dirname(__FILE__), "widgets/gtk_toggle_button.rb")
require File.join(File.dirname(__FILE__), "widgets/gtk_toggle_tool_button.rb")
require File.join(File.dirname(__FILE__), "widgets/gtk_widget.rb")
require File.join(File.dirname(__FILE__), "widgets/gtk_combo_box.rb")
require File.join(File.dirname(__FILE__), "widgets/gtk_calendar.rb")
require File.join(File.dirname(__FILE__), "widgets/gtk_treeview.rb")
require File.join(File.dirname(__FILE__), "widgets/gtk_treeviewcolumn.rb")
require File.join(File.dirname(__FILE__), "widgets/gtk_layout.rb")
require File.join(File.dirname(__FILE__), "widgets/gtk_statusicon.rb")
require File.join(File.dirname(__FILE__), "interface_builder.rb")
require File.join(File.dirname(__FILE__), "dialog_helper.rb")

module Gtk

  
end

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