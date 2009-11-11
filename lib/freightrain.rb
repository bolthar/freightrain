
require 'rubygems'

begin
  require 'libglade2'
rescue
  p "libglade2 is not available"
end

begin
  require 'Qt4'
  require 'qtuitools'
rescue
  p "qt is not available"
end
require 'needle'
require 'require_all'
require 'tmpdir'

require_all File.dirname(__FILE__) + '/freightrain'

module Freightrain

  attr_accessor :app_path
  attr_accessor :toolkit

  def self.start(viewmodel)
    auto_require!
    configure_container!    
    start_toolkit_mainloop(viewmodel)
  end

  private
  def start_toolkit_mainloop(viewmodel)
    @toolkit ||= :gtk
    
    if @toolkit == :gtk
      Freightrain[(viewmodel.to_s + "_view_model").to_sym].show
      Gtk.main
    end
    if @toolkit == :qt
      app = Qt::Application.new([])
      Freightrain[(viewmodel.to_s + "_view_model").to_sym].show
      app.exec()
    end
    
  end

end
