
module Freightrain
  
  class FreightRegion

    def initialize(name, options)
      @name          = name
      viewmodel_name = options[:viewmodel] || name
      @viewmodel     = Freightrain[(viewmodel_name.to_s + "_view_model").to_sym]
      @container     = name.to_s + "_region"
    end

    def viewmodel
      return @viewmodel
    end

    def on_show(view)
      container = view.send(@container)
      view.class.wrap_container(container).plug_in(@viewmodel.show)
    end

    def connect_to(viewmodel)
      @viewmodel.signals.each do |key, signal|
        if viewmodel.respond_to? "#{@name.to_s}_on_#{key.to_s}".to_sym
          signal.connect(viewmodel.method("#{@name.to_s}_on_#{key.to_s}".to_sym))
        end
      end
    end

  end

end
