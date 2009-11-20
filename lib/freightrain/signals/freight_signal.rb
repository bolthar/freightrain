
module Freightrain

  class FreightSignal

    def fire(*args)
      @proc.call(*args) if @proc && !@inactive
    end

    def connect(proc)
      @proc = proc
    end

    def stifle
      @inactive = true
    end

    def unleash
      @inactive = false
    end
    
  end
end