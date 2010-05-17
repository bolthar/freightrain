
require 'Qt4'
require 'qtuitools'
require File.join(File.dirname(__FILE__), "widgets/qt_base.rb")
require File.join(File.dirname(__FILE__), "widgets/qt_widget.rb")
require File.join(File.dirname(__FILE__), "widgets/qt_abstract_button.rb")
require File.join(File.dirname(__FILE__), "widgets/qt_line_edit.rb")
require File.join(File.dirname(__FILE__), "widgets/qt_label.rb")
require File.join(File.dirname(__FILE__), "interface_builder.rb")
require File.join(File.dirname(__FILE__), "dialog_helper.rb")

module Freightrain

  module Toolkit

    def self.start_main_loop
      app = Qt::Application.new([])
      yield
      app.exec
    end
    
  end

end