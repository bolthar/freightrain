
module Wx

  class Panel

    def plug_in(region_widget)
      self.remove_child(self.get_children.first) if self.get_children.length != 0
      region_widget.reparent(self)
      region_widget.layout
      self.layout
    end
    
  end
end