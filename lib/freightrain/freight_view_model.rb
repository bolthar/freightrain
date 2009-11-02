
module Freightrain

  class FreightViewModel
    extend ContainerHookable
    include ServiceHost

    def self.service(name)
      @services ||= []
      @services << name.to_sym
    end

    def initialize()
      @view = Freightrain[self.class.name.sub("Model","").to_convention_sym]
      @view.signals.each do |key,signal|
        signal.connect(method("on_" + key.to_s)) if self.respond_to? "on_" + key.to_s
      end
      @view.data_source = self
      get_services
    end

    def show      
      @view.toplevel.visible = true
    end

    def hide
      @view = nil
    end

  end
end
