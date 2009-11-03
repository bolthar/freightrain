
module Freightrain

  class ElementsConverter

    def initialize(layout)
      @layout = layout
    end

    def from(enumerable)
      
    end

  end
end

module Gtk

  class Layout

    def elements

    end

    def bind(options)
      if options[:property] == :elements
        options[:converter] ||= ElementsConverter.new(self, Freightrain["#{options[:control].to_s}View".to_convention_sym])
      end
    end



  end

end
