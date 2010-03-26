
class CallbackWrapper

  attr_reader :method

  def initialize(method)
    @method = method
  end

  def matches_widget?(widget)
    method_target_and_event = @method.name.sub("on_", "")
    return method_target_and_event.scan(/^#{widget.name}/).any?
  end

  def event_name(widget)
    event_name = @method.name.split(widget.name)[1]
    return event_name.sub("_", "").gsub("_", "-")
  end

end