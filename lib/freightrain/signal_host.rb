

module Freightrain

  module SignalHost
    
    def self.extended(klass)
      klass.send(:define_method, :fire) do |signal, *args|
        @signals[signal.to_sym].fire(*args)
      end
      klass.send(:define_method, :signals) do
        return @signals
      end
    end

    def signal(signal_name)
      @signals ||= []
      @signals << signal_name.to_sym
    end

#    def fire(signal, *args)
#      @signals[signal.to_sym].fire(*args)
#    end
#
#    def signals()
#      return @signals
#    end

    
  end

end