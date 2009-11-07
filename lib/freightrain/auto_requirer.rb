
module Freightrain

  def self.auto_require!

    require_all File.join(self.app_path, "views")
    require_all File.join(self.app_path, "viewmodels")
    require_all File.join(self.app_path, "services")
    require_all File.join(self.app_path, "domain")
    
  end
end