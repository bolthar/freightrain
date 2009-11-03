
module Freightrain

  class ElementsConverter

    def initialize(layout, element_class, signals)
      @layout             = layout
      @element_class      = element_class
      @signals            = signals
    end

    def from(enumerable)
      @layout.children.each do |child|
        @layout.remove(child)
      end
      height = 0
      enumerable.each do |value|
        ui_element = @element_class.new
        ui_element.value = value
        ui_element.select if value == layout.selected_item
        ui_element.signals.each do |key,signal|
          signal.connect(@signals[key]) if @signals[key]
        end
        @layout.put(ui_element.control, 0, height * ui_element.control.height_request)
        height += 1
      end
      @layout.height = @layout.elements.first.height_request if @layout.elements.first
    end

  end
end

module Gtk

  class Layout

    def bind(options)
      if options[:property] == :elements
        options[:converter] ||= ElementsConverter.new(
          self,
          Freightrain["#{options[:control].to_s}View".to_convention_sym],
          options[:signals]
        )
      end
    end



  end

end
