
module Wx

  class Sizer

    def plug_in(region_widget)
      self.remove(self.get_children.first) if self.get_children.length != 0
      self.add_child(region_widget)
    end

  end
end