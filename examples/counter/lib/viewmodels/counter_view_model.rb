
class CounterViewModel < FreightViewModel

  attr_reader :count

  def initialize
    @count = 0
    @view.update
  end

  def on_quit
    Toolkit.quit
  end

  def on_up_signal
    @count += 1
    @view.update
  end
end