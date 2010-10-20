require 'rubygems'
require 'freightrain'

include Freightrain

Freightrain.app_path = File.join(File.dirname(__FILE__), "lib")

Freightrain.toolkit = :gtk
Freightrain.start(:logger) #shows logger_view
