
require 'rubygems'
require 'needle'
require 'require_all'

require_all File.dirname(__FILE__) + '/freightrain' #thanks Tony!

module Freightrain

  attr_accessor :app_path

  def self.start(viewmodel)
    auto_require!
    configure_container!
    Freightrain[(viewmodel.to_s + "_view_model").to_sym].show
    Gtk.main
  end

end
