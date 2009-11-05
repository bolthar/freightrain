
module Freightrain

  class FreightViewModel
    extend ContainerHookable
    include ServiceHost

    def self.service(name)
      @services ||= []
      @services << name.to_sym
    end

    def self.region(name, options = {})
      @regions ||= {}
      @regions[:name] = options
    end

    def initialize()
      @view = Freightrain[self.class.name.sub("Model","").to_convention_sym]
      @view.signals.each do |key,signal|
        signal.connect(method("on_" + key.to_s)) if self.respond_to? "on_" + key.to_s
      end
      @view.data_source = self
      get_services
      build_regions
    end

    def show      
      @view.toplevel.visible = true
      return @view.toplevel
    end

    def hide
      @view.toplevel.visible = false
      @view = nil
    end

  end
end
