
require 'rubygems'
require 'freightrain'


module Freightrain

  def inject(name, object)
     @registry ||= Needle::Registry.new
     @registry.register(name) { object }
  end

end
 
class Object

  def inject_service(name, object)
    Freightrain.inject(name.to_s + "_service", object)
  end

end

