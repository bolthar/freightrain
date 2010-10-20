require 'rubygems'
require 'freightrain'

include Freightrain

Freightrain.app_path = File.join(File.dirname(__FILE__), "lib")

Freightrain.toolkit = :gtk
Freightrain.start(:editor) #shows editor_view