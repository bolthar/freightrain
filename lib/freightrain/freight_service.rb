# To change this template, choose Tools | Templates
# and open the template in the editor.

module Freightrain

  class FreightService
    extend ContainerHookable
    include ServiceHost

    def self.service(name)
      @services ||= []
      @services << name.to_sym
    end

    def initialize
      get_services
    end

  end
  
end
