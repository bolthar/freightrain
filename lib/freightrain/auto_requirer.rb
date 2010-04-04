
module Freightrain

  def self.auto_require!

    views_folder      = self.views_path
    viewmodels_folder = File.join(self.app_path, "viewmodels")
    services_folder   = File.join(self.app_path, "services")
    domain_folder     = File.join(self.app_path, "domain")

    require_all views_folder
    require_all viewmodels_folder
    require_all services_folder if self.must_import?(services_folder)
    require_all domain_folder   if self.must_import?(domain_folder)
  
  end

  private
  def self.must_import?(directory)
    return File.directory?(directory) && Dir.entries(directory).length > 2
  end
  
end