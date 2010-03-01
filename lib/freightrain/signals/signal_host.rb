

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

        def hook_to_signals(host, prefix = nil)
          host.signals.each do |signal_key, signal|
            method_name = "on_#{signal_key}"
            method_name = "#{prefix}_#{method_name}" if prefix
            signal.connect(method(method_name)) if self.respond_to?(method_name)
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