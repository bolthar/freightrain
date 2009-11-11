
module Freightrain

  def self.auto_require!

    views_folder      = File.join(self.app_path, "views")
    viewmodels_folder = File.join(self.app_path, "viewmodels")
    services_folder   = File.join(self.app_path, "services")
    domain_folder     = File.join(self.app_path, "domain")

    require_all File.join(views_folder)
    require_all File.join(viewmodels_folder)
    if File.directory?(services_folder) && !Dir.entries(services_folder).empty?
      require_all File.join(services_folder)
    end
    if File.directory?(domain_folder) && !Dir.entries(domain_folder).empty?
      require_all File.join(domain_folder)
    end
    
  end
  
end