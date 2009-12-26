
module Freightrain

  def configure_container!(registry = Needle::Registry.new)

    @registry = registry

    ContainerHookable.classes.each do |klass|
      klass.subclasses.each do |subclass|
        @registry.register(
          subclass.name.to_convention_sym, subclass.container_options) { subclass.new }
      end
    end

  end

  def [](class_name)    
    return @registry.send(class_name)
  end
    
end
