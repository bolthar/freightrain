



module Freightrain

    def configure_container!

    @registry = Needle::Registry.new

    views =      FreightView.subclasses
    viewmodels = FreightViewModel.subclasses
    services =   FreightService.subclasses

    if views
      views.each do |view|
        @registry.register(view.name.to_convention_sym) { view.new }
      end
    end

    if viewmodels
      viewmodels.each do |viewmodel|
        @registry.register(viewmodel.name.to_convention_sym) { viewmodel.new }
      end
    end

    if services
      services.each do |service|
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
