
module Freightrain

  class FreightViewModel
    extend ContainerHookable
    extend ServiceHost
    extend RegionHost
    extend SignalHost

    def initialize()
      @view = Freightrain[self.class.name.sub("Model","").to_convention_sym]
      @view.signals.each do |key,signal|
        signal.connect(method("on_" + key.to_s)) if self.respond_to? "on_" + key.to_s
      end
      @view.data_source = self
      get_services
      build_regions
      @regions.each do |name, region|
        region.viewmodel.signals.each do |key, signal|
          signal.connect(method("#{name.to_s}_on_#{key.to_s}".to_sym)) if self.respond_to? "#{name.to_s}_on_#{key.to_s}".to_sym
        end
      end
    end

    def show      
      @view.toplevel.visible = true
      @regions.values.each do |region|
        region.on_show(@view)
      end
      return @view.toplevel
    end

    def hide
      @view.toplevel.visible = false
      @view = nil
    end

  end
end
