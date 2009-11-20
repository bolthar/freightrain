
module Freightrain

  class FreightService
    extend ContainerHookable
    extend ServiceHost

    def initialize
      get_services
    end

  end
  
end
