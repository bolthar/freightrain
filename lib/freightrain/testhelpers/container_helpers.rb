
module Freightrain

  class Object

    def inject(name, object)
      @registry ||= Needle::Registry.new
      @registry.register(name) { object }
    end

  end

end
