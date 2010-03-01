

module Freightrain

  module ServiceHost

    def self.extended(klass)

      klass.class_eval do

        def get_services
          services = self.class.instance_variable_get(:@services)
          services ||= []
          services.each do |service|
            service_instance = Freightrain["#{service}_service".to_sym]
            instance_variable_set("@#{service}".to_sym, service_instance)
          end
        end

        def services
          return self.class.instance_variable_get(:@services) || []
        end

      end
    end

    def service(name)
      @services ||= []
      @services << name.to_sym
    end    

  end

end

