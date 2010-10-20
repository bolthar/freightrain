
class EditorView < FreightView

  signal :quit, :forwards => "editor_window.destroy"
  signal :run
  
  def execute_on_clicked
    fire :run, input.buffer.text
  end

end