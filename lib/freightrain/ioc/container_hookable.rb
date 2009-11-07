
module Freightrain

  module ContainerHookable

    def self.extended(extending_class)
      @@classes ||= []
      @@classes << extending_class
    end

    def self.classes
      @@classes ||= []
      return @@classes
    end

    def inherited(subclass)
      @subclasses ||= []
      @subclasses << subclass      
    end

    def container_options
      return {}
    end

    def subclasses
      return @subclasses || []
    end
     
  end

end
