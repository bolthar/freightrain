
module Freightrain

  def configure_container!(registry = Needle::Registry.new)

    @registry = registry

    ContainerHookable.classes.each do |klass|
      klass.subclasses.each do |subclass|
        p subclass.name.to_convention_sym
        @registry.register(
          subclass.name.to_convention_sym, subclass.container_options) { subclass.new }
      end
    end

  end

  def [](class_name)    
    begin
      return @registry[class_name]
    rescue Needle::ServiceNotFound
      raise "Could not resolve #{class_name}. Have you called 'configure_container!' already?"
    end
    
  end
    
end
