
class AppCommand

  def initialize(*args)
    raise "name parameter must be specified" if args.length < 1
    @name = args[0]
    @dir  = Dir.pwd
    @path = File.join(@dir, @name)
  end

  def check
    raise "Directory #{@name} already exists" if File.exist?(File.join(@dir, @name))
  end

  def execute
    FileUtils.mkdir(@path)
    FileUtils.mkdir(File.join(@path, "views"))
    FileUtils.mkdir(File.join(@path, "viewmodels"))
    FileUtils.mkdir(File.join(@path, "services"))
    FileUtils.mkdir(File.join(@path, "domain"))
    Generator.create_stub(File.join(@path, "#{@name}.rb"),"application", :name => @name)
    Generator.create_stub(File.join(@path, "views", "#{@name}_view.rb"), "view", :name => @name.capitalize)
    Generator.create_stub(File.join(@path, "views", "#{@name}_view.glade"), "view_toplevel_glade",:name => @name)
    Generator.create_stub(File.join(@path, "views", "#{@name}_view.bnd.yml"), "view_bnd", :name => @name)
    Generator.create_stub(File.join(@path, "viewmodels", "#{@name}_view_model.rb"), "view_model", :name => @name.capitalize)
    print "Application created in #{@path}\n"
  end
  
end