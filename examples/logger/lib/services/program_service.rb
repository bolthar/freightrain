
class ProgramService < FreightService
  
  signal :work_completed
  
  def run
    run_my_program
    fire :work_completed
  end
  
  #here goes your sample program
  def run_my_program
    p "my test program"
    p "sleep for a while..."
    sleep(3)
    p "completed!"
  end
  
end