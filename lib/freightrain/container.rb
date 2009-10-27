
module Freightrain

  def configure_container!(registry = Needle::Registry.new)

    @registry = registry

    ContainerHookable.classes.each do |klass|
      klass.subclasses.each do |subclass|
        @registry.register(subclass.name.to_convention_sym) { subclass.new }
      end
    end

  end

  def [](class_name)

    raise "registry not initialized" if !@registry

    begin
      return @registry[class_name]
    rescue Needle::ServiceNotFound
      raise "Could not resolve #{class_name}. Have you called 'configure_container!' already?"
    end
    
  end
    
end
