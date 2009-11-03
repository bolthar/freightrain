
module Freightrain

  class ElementsConverter

    def initialize(layout, element_class, signals)
      @layout             = layout
      @element_class      = element_class
      @signals            = signals
      selected_callback   = @signals[:selected]
      @signals[:selected] = lambda { |value| @layout.elements.each do |item|
                              item.set_ui_selection(item.value == value)
                              @selected_item = item
                              p @selected_item
                            end
                            selected_callback.call(value) if selected_callback
                            }
    end

    def from(enumerable)
      ui_elements = []
      enumerable.each do |value|
        ui_element = @element_class.new
        ui_element.value = value
        ui_element.set_ui_selection(ui_element.value == @selected_item.value)
        ui_element.signals.each do |key,signal|
          signal.connect(@signals[key]) if @signals[key]
        end
        ui_elements << ui_element
      end
      return ui_elements
    end

  end
end

module Gtk

  class Layout

    def elements=(ui_items)
      @elements = []
      if ui_items.length != 0
        self.children.each do |child|
          self.remove(child)
        end
        height_factor = ui_items.first.control.height_request        
        height = 0
        ui_items.each do |item|
          self.put(item.control, 0, height * height_factor)
          @elements << item
          height += 1
        end
        self.height = height * height_factor
      end
    end

    def elements
      return @elements
    end
      
    def bind(options)
      if options[:property] == :elements
        options[:converter] ||= ElementsConverter.new(
          self,
          options[:control],
          options[:signals]
        )
        options[:force] = true
      end
      super(options)
    end

  end

end
