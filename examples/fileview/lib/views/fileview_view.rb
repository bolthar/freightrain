
class FileviewView < FreightView

  signal :quit, :forwards => "fileview.destroy"
  signal :display

  def search_on_clicked
    filename.text = open_file_dialog
  end

  def display_on_clicked
    fire :display, filename.text
  end

end