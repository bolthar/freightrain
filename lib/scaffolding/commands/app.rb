
class AppCommand

  def initialize(*args)
    raise "'name' parameter must be specified" if args.length < 1
    @name = args[0]
    @dir  = Dir.pwd
    @path = File.join(@dir, @name)
  end

  def check
    raise "Directory #{@name} already exists" if File.exist?(File.join(@dir, @name))
  end

  def execute
    FileUtils.mkdir(@path)
    FileUtils.mkdir(File.join(@path, "lib"))
    FileUtils.mkdir(File.join(@path, "lib", "views"))
    FileUtils.mkdir(File.join(@path, "lib", "viewmodels"))
    FileUtils.mkdir(File.join(@path, "lib", "services"))
    FileUtils.mkdir(File.join(@path, "lib", "domain"))
    Generator.create_stub(File.join(@path, "#{@name}.rb"),"application", :name => @name)
    Generator.create_stub(File.join(@path, "lib", "views", "#{@name}_view.rb"), "view_toplevel", :name => @name.capitalize, :toplevel => @name)
    Generator.create_stub(File.join(@path, "lib", "views", "#{@name}_view.glade"), "view_toplevel_glade",:name => @name)
    Generator.create_stub(File.join(@path, "lib", "viewmodels", "#{@name}_view_model.rb"), "viewmodel_toplevel", :name => @name.capitalize)
    print "Application created in #{@path}\n"
  end
  
end
