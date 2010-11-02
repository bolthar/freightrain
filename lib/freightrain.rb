
require 'rubygems'

require 'require_all'
require 'tmpdir'

begin
  require 'mocha/api'
  require_all File.join(File.dirname(__FILE__), 'freightrain-dev')
rescue Exception
  print "info: Mocha gem not found - install it with 'gem install mocha' if you want to use AutoStubber in tests\n"
end

#HACK!!1!!
require File.join(File.dirname(__FILE__), 'scaffolding', 'scaffolding.rb') if $scaffolding
require_all File.join(File.dirname(__FILE__), 'freightrain')