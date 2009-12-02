
module Freightrain

  class FreightViewModel
    extend ContainerHookable
    extend ServiceHost
    extend RegionHost
    extend SignalHost

    def initialize()     
      @view = Freightrain[self.class.name.sub("Model", "").to_convention_sym]
      @data = Freightrain[self.class.name.sub("View", "Data").to_convention_sym] rescue nil
      get_services
      build_regions
      create_signals
      @view.signals.each do |key,signal|
        signal.connect(method("on_#{key}")) if self.respond_to? "on_#{key}"
      end
      @view.data = @data
      @regions ||= {}
      @regions.each do |name, region|
        region.viewmodel.signals.each do |key, signal|
          signal.connect(method("#{name.to_s}_on_#{key.to_s}")) if self.respond_to? "#{name.to_s}_on_#{key.to_s}"
        end
      end      
    end

    def show      
      @view.control.visible = true
      @regions.values.each do |region|
        region.on_show(@view)
      end
      return @view.control
    end

    def hide
      @view.control.visible = false
    end

  end
end
