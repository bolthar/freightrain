
module Freightrain

  module AutoStubber

    def self.stub_viewmodel(name)
      viewmodel_name = "#{name}_view_model"
      viewmodel_class = Object.const_get(viewmodel_name.from_convention)
      viewmodel_class.send(:define_method, :bootstrap) { }
      viewmodel = Freightrain[viewmodel_name.to_sym]
      viewmodel_class.instance_variable_get(:@services).each do |service|
        #stub service (recursively!)
          #stub each public method
          #inject it somewhere (on viewmodel?)
      end

      return viewmodel
    end

  end
end