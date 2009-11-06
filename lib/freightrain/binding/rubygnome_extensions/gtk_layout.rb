
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
          item = self.children.last
          self.remove(item)
          @elements.delete_if {|element| element.control == item }
        end
      end
      self.height = @elements.length * @height_factor
      (0...enumerable.length).each do |index|
        @elements[index].value = enumerable[index]
      end
      
    end

    def elements()
      return @elements
    end

    def bind(options)
      if options[:property] == :elements
        @elements           = []
        @control            = options[:control]
        @signals            = options[:signals]
        selected_callback   = @signals[:selected]
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

