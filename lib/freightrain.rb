
require 'rubygems'
require 'needle'
require 'require_all'

require_all File.dirname(__FILE__) + '/freightrain' #thanks Tony!

module Freightrain

  attr_accessor :app_path

  def self.start(viewmodel)
    require_all @app_path
    configure_container!
    viewmodel.new.show
    Gtk.main
  end

end
