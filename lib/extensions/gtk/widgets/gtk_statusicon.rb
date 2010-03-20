
module Gtk

  class StatusIcon
    include BindingBase

    def name
      return "status_icon"
    end

    def icon_path=(path)
      self.pixbuf = Gdk::Pixbuf.new(path)
    end

  end
end