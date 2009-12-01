
module Freightrain

  def self.auto_require!

    views_folder      = File.join(self.app_path, "views")
    viewmodels_folder = File.join(self.app_path, "viewmodels")
    services_folder   = File.join(self.app_path, "services")
    domain_folder     = File.join(self.app_path, "domain")

    if Dir.glob(File.join(views_folder, @toolkit.to_s)).empty?
      require_all views_folder
    else
      require_all File.join(views_folder, @toolkit.to_s)
    end
    require_all viewmodels_folder
    if File.directory?(services_folder) && Dir.entries(services_folder).length > 2
      require_all services_folder
    end
    if File.directory?(domain_folder) && Dir.entries(domain_folder).length > 2
      require_all domain_folder
    end
    
  end
  
end