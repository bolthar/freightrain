

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
          signals ||= {}
          signals.keys.each do |signal|
            create_forward_method(signals[signal][:forwards], signal) if signals[signal]
            @signals[signal] = FreightSignal.new
          end
        end

        def create_forward_method(target_description, signal)
          target = target_description.split(".")[0]
          event  = target_description.split(".")[1]
          self.class.send(:define_method, "#{target}_on_#{event}") do
            fire signal.to_sym
          end
        end

        def hook_to_signals(host, prefix = nil)
          @signals.each do |signal_key, signal|
            method_name = "on_#{signal_key}"
            method_name = "#{prefix}_#{method_name}" if prefix
            signal.connect(host.method(method_name)) if host.respond_to?(method_name)
          end
        end

        
      end
    end

    def signal(signal_name, options = nil)
      @signals ||= {}
      @signals[signal_name.to_sym] = options
    end
    
  end

end