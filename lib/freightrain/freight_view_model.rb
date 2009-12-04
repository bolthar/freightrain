
module Freightrain

  class FreightViewModel
    extend ContainerHookable
    extend ServiceHost
    extend RegionHost
    extend SignalHost

    def self.container_options
      return { :model => :prototype }
    end

    def dialog(viewmodel_name, *args)
      dialog = Freightrain["#{viewmodel_name}_view_model".to_sym]      
      dialog.show_dialog(*args) do |*params|
        yield(*params)
      end
    end

    def initialize()     
      @view = Freightrain[self.class.name.sub("Model", "").to_convention_sym]      
      get_services
      build_regions
      create_signals
      @view.signals.each do |key,signal|
        signal.connect(method("on_#{key}")) if self.respond_to? "on_#{key}"
      end
      @view.data = self
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
