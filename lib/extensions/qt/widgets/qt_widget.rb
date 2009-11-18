

module Qt

  class Widget

    def elements=(enumerable)
      delta = enumerable.length - @elements.length
      p @control.new.control
      p @control.new.widgets
      @height_factor = @control.new.control.height unless @height_factor
      height = @elements.length
      delta.abs.times do
        if delta > 0
          item = @control.new
          item.signals.each do |key, signal|
            signal.connect(@signals[key]) if @signals[key]
          end
          item.control.geometry = Qt::Rect.new(
            0,
            item.control.height * height,
            item.control.width,
            item.control.height
          )
          item.control.setParent(self)
          item.control.show
          @elements << item
          height += 1
        else
          item = self.children.last
          item.control.setParent(nil)
          @elements.delete_if {|element| element.control == item }
          item.control = nil
        end
      end
      self.setMinimumHeight(@elements.length * @height_factor)
      self.show
      @elements.each do |element|
        element.value = enumerable[@elements.index(element)]
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
        options[:force]     = true
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
