
module Freightrain

  module AutoStubber

    def self.stub_viewmodel(name)
      viewmodel_name = "#{name}_view_model"
      Object.const_get(viewmodel_name).define_method(:bootstrap) { }
      viewmodel = Freightrain[viewmodel_name.to_sym]
    end

  end
end