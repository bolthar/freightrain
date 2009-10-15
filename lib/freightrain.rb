
module Freightrain

  def self.APP_PATH= (value)
    @app_path = value
  end

  def self.APP_PATH()
    return @app_path
  end

end

require File.dirname(__FILE__) + '/freightrain/gtk_builder_helper.rb'
require File.dirname(__FILE__) + '/freightrain/dialog_helper.rb'
require File.dirname(__FILE__) + '/freightrain/freight_view.rb'
