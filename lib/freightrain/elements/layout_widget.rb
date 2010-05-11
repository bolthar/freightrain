
#TODO: remove this
module Freightrain
  module LayoutWidget
    
    def add_signal_callback(signal, proc)
      @signals ||= {}
      @signals[signal] = proc
    end

  end
end
