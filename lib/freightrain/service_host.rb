

module Freightrain

  module ServiceHost

    def get_services()
      services = self.class.instance_variable_get(:@services)
      services ||= []
      services.each do |service|
        eval "@#{service} = Freightrain[:#{service.to_s}_service]"
      end
    end

  end

end

