
module Freightrain

  class FreightService
    extend ContainerHookable
    extend ServiceHost
    extend SignalHost

    def initialize
      get_services
      create_signals
    end

  end
  
end
