
module Freightrain

  module BindingHost

    def data_source=(source)
      @data_source = source
      bindings.each do |binding|
        binding.data_source = @data_source
        binding.update
      end
    end
    
    def bindings
      return widgets.each.map { |widget| widget.bindings }.flatten
    end

    def commit
      bindings.each { |binding| binding.commit }
    end

    def update
      bindings.each { |binding| binding.update}
    end



  end

end