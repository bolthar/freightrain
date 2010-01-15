
class TriadCommand

  def initialize(*args)
    raise "name parameter must be specified" if args.length < 1
    @name = args[0]
    @path  = Dir.pwd
  end

  def check
    raise "not a freightrain application" unless File.exist?(File.join(@path, "views"))
    raise "not a freightrain application" unless File.exist?(File.join(@path, "viewmodels"))
    raise "#{@name} view already exists"  if File.exist?(File.join(@path, "views", "#{@name}_view.rb"))
    raise "#{@name} view definition already exists" if File.exist?(File.join(@path, "views", "#{@name}_view.glade"))
    raise "#{@name} view binding file already exists" if File.exist?(File.join(@path, "views", "#{@name}_view.bnd.yml"))
    raise "#{@name} viewmodel already exists" if File.exist?(File.join(@path, "viewmodels", "#{@name}_view_model.rb"))

  end

  def execute
    Generator.create_stub(File.join(@path, "views", "#{@name}_view.rb"), "view", :name => @name.capitalize)
    Generator.create_stub(File.join(@path, "views", "#{@name}_view.glade"), "view_control_glade",:name => @name)
    Generator.create_stub(File.join(@path, "views", "#{@name}_view.bnd.yml"), "view_bnd", :name => @name)
    Generator.create_stub(File.join(@path, "viewmodels", "#{@name}_view_model.rb"), "view_model", :name => @name.capitalize)
    print "#{@name} triad created\n"
  end


end