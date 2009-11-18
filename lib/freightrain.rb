
require 'rubygems'

require 'needle'
require 'require_all'
require 'tmpdir'

require_all File.dirname(__FILE__) + '/freightrain'

module Freightrain

  attr_accessor :app_path
  attr_accessor :toolkit

  def self.start(viewmodel_name)
    @toolkit ||= :gtk
    load_extensions!
    auto_require!
    configure_container!    
    start_toolkit_mainloop(viewmodel_name)
  end

  private
  

end
