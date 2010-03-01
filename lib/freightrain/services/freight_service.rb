
module Freightrain

  class FreightService
    extend ContainerHookable
    extend ServiceHost
    extend SignalHost

    def initialize
      get_services
      create_signals
      services = self.class.instance_variable_get(:@services)
      services ||= []
      services.each do |service_key|
        service = instance_variable_get("@#{service_key}")
        service.signals.each do |signal_key, signal|
          method_name = "#{service_key}_on_#{signal_key}"
          signal.connect(method_name) if self.respond_to?(method_name)
        end
      end
    end

  end
  
end
