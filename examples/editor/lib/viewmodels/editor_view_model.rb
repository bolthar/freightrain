
class EditorViewModel < FreightViewModel

  service :output
  service :program
  
  attr_reader :idle
  attr_reader :state
  
  def initialize
    @idle = true
    @state = "Execute" 
    @view.update
    $stdout = @output           
  end
  
  def on_quit
    Toolkit.quit
  end
  
  def on_run(code)
    @program.code = code
    @output.reset
    @idle = false
    @state = "Running..."
    @view.update    
    Thread.new do 
      @program.run
      @view.update
    end
  end
  
  def output_on_write
    @view.update
  end
  
  def program_on_work_completed
    @idle = true
    @state = "Execute"    
    @view.update
  end
  
  def program_output
    return @output.program_output
  end

end