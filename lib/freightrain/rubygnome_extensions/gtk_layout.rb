
module Freightrain

  class ElementsConverter

    def initialize(layout)
      @layout = layout
    end

    def from(enumerable, control)
      
    end

  end
end

module Gtk

  class Layout

    def elements

    end

    def bind(options)
      if options[:property] == :elements
        options[:converter] ||= ElementsConverter.new(self, Freightrain[options[:control].to_convention.sym)
      end
    end



  end

end
