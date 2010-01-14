
require File.dirname(__FILE__) + "/generator.rb"

p "FREIGHTRAIN - SCAFFOLDING"

if ARGV[0].to_s == "triad" 
  name        = ARGV[1].to_s
  current_dir = Dir.pwd
  Generator.create_stub(File.join(current_dir, "views", "#{name}_view.rb"),"view",:name => name.capitalize)
  Generator.create_stub(File.join(current_dir, "views", "#{name}_view.bnd.yml"),"view_bnd",:name => name)
  Generator.create_stub(File.join(current_dir, "views", "#{name}_view.glade"),"view_control_glade",:name => name)
  Generator.create_stub(File.join(current_dir, "viewmodels", "#{name}_view_model.rb"),"view_model",:name => name.capitalize)
end