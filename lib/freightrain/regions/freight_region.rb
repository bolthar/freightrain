
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
      p "#{@viewmodel.class.name} in #{view.class.name}"
      container = view.send(@container)
      view.class.wrap_container(container).plug_in(@viewmodel.show)
      p "end #{@viewmodel.class.name}"
    end

    def change(viewmodel, view)
      new_viewmodel = Freightrain[(viewmodel.to_s + "_view_model").to_sym]
      if new_viewmodel != @viewmodel
        p new_viewmodel
        @viewmodel = new_viewmodel
        container = view.send(@container)
        view.class.wrap_container(container).plug_in(@viewmodel.show)
      end
    end

  end

end
