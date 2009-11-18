
require 'Qt4'
require 'qtuitools'
require File.dirname(__FILE__) + "/widgets/qt_base.rb"
require File.dirname(__FILE__) + "/widgets/qt_widget.rb"
require File.dirname(__FILE__) + "/widgets/qt_labelw.rb"
require File.dirname(__FILE__) + "/interface_builder.rb"
require File.dirname(__FILE__) + "/region_container.rb"

module Freightrain

  module Toolkit

    def self.start_main_loop
      Qt::Application.new([]).exec
    end
    
  end

end