

module Freightrain

  module SignalHost
    
    def self.extended(klass)

      klass.send(:define_method, :fire) do |signal, *args|
        @signals[signal.to_sym].fire(*args)
      end

      klass.send(:define_method, :signals) do
        return @signals
      end

      klass.send(:define_method, :create_signals) do
        @signals = {}
        signals = self.class.instance_variable_get(:@signals)
        signals ||= []
        signals.each do |signal|
          @signals[signal] = FreightSignal.new
        end
      end
      
    end

    def signal(signal_name)
      @signals ||= []
      @signals << signal_name.to_sym
    end
    
  end

end