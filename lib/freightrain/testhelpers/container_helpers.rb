
require 'rubygems'
require 'freightrain'

class Object

  def inject_service(name, object)
    Freightrain.inject(name.to_s + "_service", object)
  end

end
