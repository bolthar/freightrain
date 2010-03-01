

module Freightrain

  module SignalHost
    
    def self.extended(klass)

      klass.class_eval do

        def fire(signal, *args)
          @signals[signal.to_sym].fire(*args)
        end
        
        def signals
          return @signals
        end
        
        def create_signals
          @signals = {}
          signals = self.class.instance_variable_get(:@signals)
          signals ||= []
          signals.each do |signal|
            @signals[signal] = FreightSignal.new
          end
        end

        
      end
    end

    def signal(signal_name)
      @signals ||= []
      @signals << signal_name.to_sym
    end
    
  end

end