
class Color

  @@colors = {}
  @@colors[:red]   = [255, 0, 0]
  @@colors[:green] = [0, 255, 0]
  @@colors[:blue]  = [0, 0, 255]

  def self.[](color_symbol)
    return @@colors[color_symbol]
  end
end