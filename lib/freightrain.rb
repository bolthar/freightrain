
require 'rubygems'

require 'needle'
require 'require_all'
require 'tmpdir'

#HACK!!1!!
require File.join(File.dirname(__FILE__), 'scaffolding', 'scaffolding.rb') if $scaffolding
require_all File.join(File.dirname(__FILE__), 'freightrain')
