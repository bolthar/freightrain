
module Freightrain

  class FreightSignal

    def fire(*args)
      @proc.call(*args) if @proc && !@stifle
    end

    def connect(proc)
      @proc = proc
    end

    def stifle
      @stifle = true
    end

    def unleash
      @stifle = false
    end
    
  end
end