
class ProgramService < FreightService
  
  signal :work_completed
  
  def run
    begin
      eval(@code)
    rescue Exception => ex
      print ex.message + "\n"
    end
    
    fire :work_completed
  end 
  
  def code=(text)
    @code = text
  end  
  
end