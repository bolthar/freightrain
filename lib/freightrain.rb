
require 'rubygems'
require 'needle'

module Freightrain

  attr_accessor :app_path

  def self.start(viewmodel)
    auto_require!
    configure_container!
    viewmodel.new.show
    Gtk.main
  end

end

require File.dirname(__FILE__) + '/freightrain/string_patch.rb'
require File.dirname(__FILE__) + '/freightrain/container.rb'
require File.dirname(__FILE__) + '/freightrain/container_hookable.rb'
require File.dirname(__FILE__) + '/freightrain/freight_signal.rb'
require File.dirname(__FILE__) + '/freightrain/gtk_builder_helper.rb'
require File.dirname(__FILE__) + '/freightrain/dialog_helper.rb'
require File.dirname(__FILE__) + '/freightrain/freight_binding.rb'
require File.dirname(__FILE__) + '/freightrain/data_source_shell.rb'
require File.dirname(__FILE__) + '/freightrain/rubygnome_extensions/gtk_widget.rb'
require File.dirname(__FILE__) + '/freightrain/rubygnome_extensions/gtk_entry.rb'
require File.dirname(__FILE__) + '/freightrain/binding_host.rb'
require File.dirname(__FILE__) + '/freightrain/freight_view.rb'
require File.dirname(__FILE__) + '/freightrain/freight_view_model.rb'
require File.dirname(__FILE__) + '/freightrain/freight_service.rb'
require File.dirname(__FILE__) + '/freightrain/auto_requirer.rb'