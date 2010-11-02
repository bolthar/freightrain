
module Freightrain

  def configure_container!(registry = Freightrain::Registry.new)

    @registry = registry

    ContainerHookable.classes.each do |klass|
      klass.subclasses.each do |subclass|
        @registry.register(
          subclass, subclass.container_options)
      end
    end

  end

  def [](class_name)    
    return @registry.resolve(class_name)
  end
    
end
