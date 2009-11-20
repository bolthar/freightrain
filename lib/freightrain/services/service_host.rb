

module Freightrain

  module ServiceHost

    def self.extended(klass)
      klass.send(:define_method,:get_services) do
        services = self.class.instance_variable_get(:@services)
        services ||= []
        services.each do |service|
          eval "@#{service} = Freightrain[:#{service.to_s}_service]"
        end
      end
    end

    def service(name)
      @services ||= []
      @services << name.to_sym
    end

  end

end

