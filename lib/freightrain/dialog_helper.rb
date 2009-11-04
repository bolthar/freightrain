
module Freightrain

  module DialogHelper

    
    def open_file_dialog(description = "Open file...")
      raise "toplevel not implemented. If you want to use " +
             "DialogHelper inside your class you should provide " +
             "a toplevel widget via the toplevel method" unless respond_to? :toplevel
      dialog = Gtk::FileChooserDialog.new(description,
                                          toplevel,
                                          Gtk::FileChooser::ACTION_OPEN,
                                          nil,
                                          [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL],
                                          [Gtk::Stock::OPEN, Gtk::Dialog::RESPONSE_ACCEPT])
      if dialog.run == Gtk::Dialog::RESPONSE_ACCEPT
        result = dialog.filename
      end
      dialog.destroy
      return result
    end

    def yes_no_dialog(description)
      raise "toplevel not implemented. If you want to use " +
             "DialogHelper inside your class you should provide " +
             "a toplevel widget via the toplevel method" unless respond_to? :toplevel
        result = false
        dialog = Gtk::MessageDialog.new(
        toplevel,
        Gtk::Dialog::MODAL,
        Gtk::MessageDialog::QUESTION,
        Gtk::MessageDialog::BUTTONS_YES_NO,
        description)
        dialog.title = "Attenzione!"
        dialog.secondary_text = "Non sara' possibile recuperare i dati eliminati"
        dialog.run do |response|
            result = (response == Gtk::Dialog::RESPONSE_YES)
        end
        dialog.destroy
        return result

    end

  end

end
