
require 'Qt4'
require 'qtuitools'
require File.dirname(__FILE__) + "/widgets/qt_base.rb"
require File.dirname(__FILE__) + "/widgets/qt_widget.rb"
require File.dirname(__FILE__) + "/widgets/qt_label.rb"
require File.dirname(__FILE__) + "/interface_builder.rb"
require File.dirname(__FILE__) + "/region_container.rb"

module Freightrain

  module Toolkit

    def self.start_main_loop
      app = Qt::Application.new([])
      yield
      app.exec
    end
    
  end

end