
module Freightrain
  module LayoutWidget
    
    def add_signal_callback(signal, proc)
      p signal
      @signals ||= {}
      @signals[signal] = proc
    end

  end
end
