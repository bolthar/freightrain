
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

    def subclasses
      return @subclasses || []
    end

    def container_options
      @container_options ||= {}
      return @container_options
    end
      
  end

end
