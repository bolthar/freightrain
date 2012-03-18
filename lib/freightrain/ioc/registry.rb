
module Freightrain
  
  class Registry
    
    def initialize
      @classes = {}
      @cache = {}      
    end
    
    def register(klass, options)      
      @classes[klass.name.to_convention_sym] = klass
      @cache[klass.name.to_convention_sym] = klass.new if options[:model] == :singleton            
    end
    
    def resolve(class_name)
      raise "Could not instance class #{class_name}" unless @classes.has_key?(class_name)
      return @cache[class_name] || @classes[class_name].new
    end
    
  end
  
end
