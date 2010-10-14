
class FileviewViewModel < FreightViewModel

  attr_reader :file_content

  service :file

  def on_quit
    Toolkit.quit
  end

  def on_display(filename)
    @file_content = @file.load_file(filename)
    @view.update
  end

end