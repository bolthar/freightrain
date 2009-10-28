
module Freightrain

  module Bindable

    def data_source=(source)
      @data_source = source
      @bindings.each do |binding|
        binding.data_source = @data_source
        binding.update
      end
    end


  end

end