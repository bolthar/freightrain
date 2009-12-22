
module Freightrain
  
  class FreightRegion

    def initialize(name, options)
      viewmodel_name = options[:viewmodel] || name
      @viewmodel = Freightrain[(viewmodel_name.to_s + "_view_model").to_sym]
      @container = name.to_s + "_region"
    end

    def viewmodel
      return @viewmodel
    end

    def on_show(view)
      container = view.send(@container)
      view.class.wrap_container(container).plug_in(@viewmodel.show)
    end  

  end

end
