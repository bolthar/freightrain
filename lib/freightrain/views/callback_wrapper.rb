
class CallbackWrapper

  attr_reader :method

  def initialize(method)
    @method = method
  end

  def target
    return @method.name.split("_on_")[0]
  end

  def event
    return @method.name.split("_on_")[1].gsub("_", "-")
  end

end