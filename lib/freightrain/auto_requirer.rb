# To change this template, choose Tools | Templates
# and open the template in the editor.

module Freightrain

  def self.auto_require!
    raise "APP_PATH not set. You should set APP_PATH to your application path " +
          "before calling Freightrain.start" unless self.APP_PATH
    Dir.glob(File.join(self.APP_PATH,"views","**/*.rb")).each { |view| require view }
    Dir.glob(File.join(self.APP_PATH,"domain","**/*.rb")).each { |model| require model }
    Dir.glob(File.join(self.APP_PATH,"viewmodels","**/*.rb")).each { |viewmodel| require viewmodel }
    Dir.glob(File.join(self.APP_PATH,"services","**/*.rb")).each { |service| require service }
  end

end
