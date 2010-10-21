
class CounterView < FreightView

  signal :quit, :forwards => "counter.destroy"
  signal :up_signal, :forwards => "upButton.clicked"

end