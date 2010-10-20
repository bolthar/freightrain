
class OutputService < FreightService
  
  signal :write 
  
  attr_reader :program_output
  
  def write(text)
    @program_output += text
    fire :write
  end
  
  def reset
    @program_output = ""
  end
  
  
end