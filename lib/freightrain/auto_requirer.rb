# To change this template, choose Tools | Templates
# and open the template in the editor.

module Freightrain

  def self.auto_require!
    raise "APP_PATH not set. You should set APP_PATH to your application path " +
          "before calling Freightrain.start" unless self.app_path
    Dir.glob(File.join(self.app_path,"views","**/*.rb")).each { |view| require view }
    Dir.glob(File.join(self.app_path,"domain","**/*.rb")).each { |model| require model }
    Dir.glob(File.join(self.app_path,"viewmodels","**/*.rb")).each { |viewmodel| require viewmodel }
    Dir.glob(File.join(self.app_path,"services","**/*.rb")).each { |service| require service }
  end

end
