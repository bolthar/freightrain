

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'rubygems'
require 'spec'
require 'mocha'
require 'needle'
require 'test/unit'
require 'freightrain.rb'

include Freightrain

Spec::Runner.configure do |config|
    config.mock_with :mocha
end
