
module Freightrain

  def self.auto_require!

    views_folder      = File.join(self.views_path, "views")
    viewmodels_folder = File.join(self.app_path, "viewmodels")
    datamodels_folder = File.join(self.app_path, "datamodels")
    services_folder   = File.join(self.app_path, "services")
    domain_folder     = File.join(self.app_path, "domain")

    require_all views_folder
    require_all viewmodels_folder
    require_all datamodels_folder

    if File.directory?(services_folder) && Dir.entries(services_folder).length > 2
      require_all services_folder
    end
    if File.directory?(domain_folder) && Dir.entries(domain_folder).length > 2
      require_all domain_folder
    end
    
  end
  
end