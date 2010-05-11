
#TODO: find a good templating system to import and ditch this hack
require "rubygems"
require "require_all"

require_all File.join(File.dirname(__FILE__), "commands")

require File.join(File.dirname(__FILE__), "generator.rb")

begin
  klass = eval("#{ARGV[0].capitalize}Command")
rescue
  print "No command '#{ARGV[0]}'\n"
end

begin
  command = klass.new(*ARGV[1...ARGV.length])
  command.check
  command.execute
rescue Exception => ex
  print ex.message + "\n"
end