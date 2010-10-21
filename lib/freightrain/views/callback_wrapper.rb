
#TODO: is this really necessary?
class CallbackWrapper

  attr_reader :method

  def initialize(method)
    @method = method
  end

  def target
    return @method.name.to_s.split("_on_")[0]
  end

  def event
    return @method.name.to_s.split("_on_")[1].gsub("_", "-")
  end

end