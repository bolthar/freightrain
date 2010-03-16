
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
      view      = Freightrain[viewmodel.class.name.sub("Model", "").to_convention_sym]
      viewmodel.get_services
      viewmodel.build_regions
      viewmodel.create_signals
      view.hook_to_signals(viewmodel)
      viewmodel.services.each do |service_key|
        service = viewmodel.instance_variable_get("@#{service_key}")
        service.hook_to_signals(self, service_key)
      end
      view.data_source = viewmodel
      viewmodel.instance_variable_set(:@view, view)
      viewmodel.send(:initialize, *args, &block)
      return viewmodel
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
