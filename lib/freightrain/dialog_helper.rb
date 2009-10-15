# To change this template, choose Tools | Templates
# and open the template in the editor.

module Freightrain

  module DialogHelper

    def open_file_dialog(description = "Open file...")
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

  end

end
