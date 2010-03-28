
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
        yield(*params) if block_given?
      end
    end

    def self.new(*args, &block)
      viewmodel = allocate
      viewmodel.bootstrap
      viewmodel.send(:initialize, *args, &block)
      return viewmodel
    end

    def bootstrap
      view = Freightrain[self.class.name.sub("Model", "").to_convention_sym]
      self.get_services
      self.build_regions
      self.create_signals
      view.hook_to_signals(self)
      self.services.each do |service_key|
        service = self.instance_variable_get("@#{service_key}")
        service.hook_to_signals(self, service_key)
      end
      view.data_source = self
      @view = view
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
