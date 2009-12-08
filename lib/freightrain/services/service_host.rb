

module Freightrain

  module ServiceHost

    def self.extended(klass)

      klass.class_eval do

        def get_services
          services = self.class.instance_variable_get(:@services)
          services ||= []
          services.each do |service|
            eval "@#{service} = Freightrain[:#{service.to_s}_service]"
          end
        end

      end
    end

    def service(name)
      @services ||= []
      @services << name.to_sym
    end

  end

end

