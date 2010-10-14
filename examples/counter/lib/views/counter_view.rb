
class CounterView < FreightView

  signal :quit, :forwards => "counter.destroy"
  signal :up, :forwards => "up.clicked"

end