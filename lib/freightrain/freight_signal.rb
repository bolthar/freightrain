
module Freightrain

  class FreightSignal

    def fire(*args)
      @proc.call(*args) if @proc
    end

    def connect(proc)
      @proc = proc
    end
    
  end
end