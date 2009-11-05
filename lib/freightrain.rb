
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
require File.dirname(__FILE__) + '/freightrain/service_host.rb'
require File.dirname(__FILE__) + '/freightrain/gtk_builder_helper.rb'
require File.dirname(__FILE__) + '/freightrain/dialog_helper.rb'
require File.dirname(__FILE__) + '/freightrain/binding/freight_binding.rb'
require File.dirname(__FILE__) + '/freightrain/binding/converters/default_converter.rb'
require File.dirname(__FILE__) + '/freightrain/binding/converters/list_store_converter.rb'
require File.dirname(__FILE__) + '/freightrain/binding/rubygnome_extensions/gtk_widget.rb'
require File.dirname(__FILE__) + '/freightrain/binding/rubygnome_extensions/gtk_layout.rb'
require File.dirname(__FILE__) + '/freightrain/binding/rubygnome_extensions/gtk_image.rb'
require File.dirname(__FILE__) + '/freightrain/binding/rubygnome_extensions/gtk_treeview.rb'
require File.dirname(__FILE__) + '/freightrain/binding/rubygnome_extensions/gtk_treeviewcolumn.rb'
require File.dirname(__FILE__) + '/freightrain/binding/binding_host.rb'
require File.dirname(__FILE__) + '/freightrain/freight_view.rb'
require File.dirname(__FILE__) + '/freightrain/freight_element_view.rb'
require File.dirname(__FILE__) + '/freightrain/freight_view_model.rb'
require File.dirname(__FILE__) + '/freightrain/freight_service.rb'
require File.dirname(__FILE__) + '/freightrain/auto_requirer.rb'