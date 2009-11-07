
module Freightrain
  
  class FreightRegion

    def initialize(name, options)
      @container = name.to_s + "_region"
      @viewmodel = Freightrain[(name.to_s + "_view_model").to_sym]
    end

    def viewmodel
      return @viewmodel
    end

    def on_show(view)     
      container = @viewmodel.show      
      view.send(@container) << container
    end

  end

end
