
module Freightrain

  class FreightService
    extend ContainerHookable
    extend ServiceHost
    #WARNING! Service, as it is right now, are
    #SINGLETONS by default. That means if you consume
    #the same service from two different hosts, the LAST
    #host hooking to the callback will actually get the calls.
    #TODO: make it transient?
    extend SignalHost

    def initialize
      get_services
      create_signals       
      services.each do |service_key|
        service = instance_variable_get("@#{service_key}")
        service.hook_to_signals(self, service_key)
      end
    end

  end
  
end
