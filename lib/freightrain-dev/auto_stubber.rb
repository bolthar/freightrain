
module Freightrain

  class AutoStubber
    include Mocha::API

    #semi-private API
    def stub_signals(signal_host)
      stub_signals = {}
      signal_names = []
      signals      = signal_host.class.instance_variable_get(:@signals)
      signal_names = signals.keys if signals
      signal_names.each do |signal_name|
        stub_signals[signal_name] = stub_everything
      end
      signal_host.instance_variable_set(:@signals, stub_signals)
      signal_host.class.send(:define_method, :should_fire) do |signal_name|
        return instance_variable_get(:@signals)[signal_name].expects(:fire)
      end
    end

    def stub_regions(region_host)
      stub_regions = {}
      region_names = []
      regions      = region_host.class.instance_variable_get(:@regions)
      region_names = regions.keys if regions
      region_names.each do |region_name|
        stub_regions[region_name] = stub_everything
        region_host.class.send(:define_method, region_name) do
          return instance_variable_get(:@regions)[region_name]
        end
      end
      region_host.instance_variable_set(:@regions, stub_regions)
      region_host.class.send(:define_method, :should_change_region) do |region_name, viewmodel_name|
        return region_host.expects(:change_region).with(region_name, viewmodel_name)
      end
    end

    def stub_services(service_host)
      service_names = []
      services      = service_host.class.instance_variable_get(:@services)
      service_names = services.keys if services
      service_names.each do |service|
        service_stub = stub_everything
        service_host.instance_variable_set("@#{service}", service_stub)
        service_host.class.send(:define_method, service) do
          return instance_variable_get("@#{service}")
        end
      end
    end

    def stub_view(viewmodel)
      viewmodel.instance_variable_set(:@view, stub_everything)
      viewmodel.class.send(:define_method, "view") do
        return instance_variable_get(:@view)
      end
    end

    def stub_viewmodel(name)
      viewmodel_name = "#{name}_view_model"
      viewmodel = Freightrain[viewmodel_name.to_sym]
      viewmodel.class.send(:define_method, :bootstrap) { }
      stub_services(viewmodel)
      stub_signals(viewmodel)
      stub_regions(viewmodel)
      stub_view(viewmodel)
      return viewmodel
    end
    
    def stub_service(name)
      service_name  = "#{name}_service"
      service       = Freightrain[service_name.to_sym]
      stub_services(service)
      stub_signals(service)
      return service
    end
    
  end
end