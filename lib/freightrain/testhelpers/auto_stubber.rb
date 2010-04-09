
require 'mocha/api'

module Freightrain

  class AutoStubber
    include Mocha::API

    def stub_viewmodel(name)
      viewmodel_name = "#{name}_view_model"
      viewmodel_class = Object.const_get(viewmodel_name.from_convention)
      viewmodel_class.send(:define_method, :bootstrap) { }
      viewmodel = Freightrain[viewmodel_name.to_sym]
      viewmodel_class.instance_variable_get(:@services).each do |service|
        service_stub = stub_everything
        viewmodel.instance_variable_set("@#{service}", service_stub)
        viewmodel.class.send(:define_method, service) do
          return instance_variable_get("@#{service}")
        end
      end
      viewmodel.instance_variable_set(:@view, stub_everything)
      viewmodel.class.send(:define_method, "view") do
        return instance_variable_get(:@view)
      end
      return viewmodel
    end
    
  end
end