
module Gtk

  class StatusIcon
    include BindingBase

    #Gtk::StatusIcon is NOT a Gtk::Widget, but a more basic
    #GLib::Object. That implies that statusicons do not have
    #a 'name' method, which is necessary for a lot of stuff
    #in freightrain, such as method accessor creation and
    #binding. Since, in most other aspect, statusicons behave
    #very likely other widgets, i decided to hard patch the problem
    #as follows.
    #This means that ALL the Gtk::StatusIcon you define will
    #be called 'status_icon', regardless of the name you define
    #in Glade. If, for some weird reason, you need to use TWO
    #statusicons inside the same view, you can either fix
    #this yourself (and send me a patch :-) ) or contact me.
    def name
      return "status_icon"
    end

    def icon_path=(path)
      self.pixbuf = Gdk::Pixbuf.new(path)
    end

  end
end