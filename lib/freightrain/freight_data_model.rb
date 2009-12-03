
module Freightrain
  
  class FreightDataModel
    extend ContainerHookable
    
    def set_update_proc(proc)
      @update_proc = proc
    end
    
    def set_commit_proc(proc)
      @commit_proc = proc
    end

    def update
      @update_proc.call
    end

    def commit
      @commit_proc.call
    end

    def self.container_options
      return { :model => :prototype }
    end
    
  end

end

