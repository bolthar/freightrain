
#module Freightrain
#
#  class ElementsConverter
#
#    def initialize(layout, element_class, signals)
#      @layout             = layout
#      @element_class      = element_class
#      @signals            = signals
#      selected_callback   = @signals[:selected]
#      @signals[:selected] = lambda { |value| @layout.elements.each do |item|
#                              item.set_ui_selection(item.value == value)
#                              @layout.selected_item = item
#                            end
#                            selected_callback.call(value) if selected_callback
#                            }
#    end
#
#    def from(enumerable)
#      ui_elements = []
#      enumerable.each do |value|
#        ui_element = @element_class.new
#        ui_element.value = value
#        if @selected_item
#          ui_element.set_ui_selection(ui_element.value == @selected_item.value)
#        end
#        ui_element.signals.each do |key,signal|
#          signal.connect(@signals[key]) if @signals[key]
#        end
#        ui_elements << ui_element
#      end
#      return ui_elements
#    end
#
#  end
#end

module Gtk

  class Layout

    def elements=(enumerable)
      delta = enumerable.length - @elements.length
      @height_factor = @control.new.control.height_request unless @height_factor
      height = @elements.length
      delta.abs.times do
        if delta > 0
          item = @control.new
          item.signals.each do |key, signal|
            signal.connect(@signals[key]) if @signals[key]
          end
          self.put(item.control, 0, item.control.height_request * height)
          @elements << item
          height += 1
        else
          self.remove(@elements.pop.control)
        end
      end
      self.height = @elements.length * @height_factor
      (0..enumerable.length).each do |index|
        @elements[index].value = enumerable[index]
      end
      
    end

    def elements()
      return @elements
    end

    def bind(options)
      if options[:property] == :elements
        @elements = []
        options[:force] = true
        @control = options[:control]
        @signals = options[:signals]
        selected_callback = @signals[:selected]
        @signals[:selected] = lambda do |value|
                                elements.each do |item|
                                  item.set_ui_selection(item.value == value)
                                end
                                selected_callback.call(value) if selected_callback
                              end
      end
      super(options)
    end
      
  end

end

