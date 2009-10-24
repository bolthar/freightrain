



module Freightrain

    def configure_container!

    @registry = Needle::Registry.new
    FreightView.subclasses.each do |view|
      @registry.register(view.name.to_sym) { view.new }
    end
    FreightViewModel.subclasses.each do |viewmodel|
      @registry.register(viewmodel.name.to_sym) { viewmodel.new }
    end
    FreightService.subclasses.each do |service|
      @registry.register(service.name.to_convention_sym) { service.new }
    end

  end

  def [](class_name)
    return @registry[class_name]
  end
    
end
