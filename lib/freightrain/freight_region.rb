
module Freightrain
  ù
  class FreightRegion

    def initialize(name, options)
      @container       = name.to_s + "_region"
      @viewmodel_class = Freightrain[(name + "_view_model").to_sym]
    end

    def on_show(view)
      @viewmodel = @viewmodel_class.new
      view.send(@container) << @viewmodel.show
    end

  end

end
