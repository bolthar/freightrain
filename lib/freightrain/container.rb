



module Freightrain

    def configure_container!

    @registry = Needle::Registry.new

    if FreightView.subclasses
      FreightView.subclasses.each do |view|
        @registry.register(view.name.to_convention_sym) { view.new }
      end
    end

    if FreightViewModel.subclasses
      FreightViewModel.subclasses.each do |viewmodel|
        @registry.register(viewmodel.name.to_convention_sym) { viewmodel.new }
      end
    end

    if FreightService.subclasses
      FreightService.subclasses.each do |service|
        @registry.register(service.name.to_convention_sym) { service.new }
      end
    end

  end

  def [](class_name)
    raise "registry not initialized" if !@registry
    return @registry[class_name]
  end

  def inject(name, object)
      @registry ||= Needle::Registry.new
      @registry.register(name) { object }
  end
    
end
