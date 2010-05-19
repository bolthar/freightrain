
module Qt

  class Widget
    include Freightrain::LayoutWidget
    
    def setup
      @signals ||= {}
      selected_callback   = @signals[:selected]
      @signals[:selected] = lambda do |value|
                              elements.each do |item|
                                item.set_selection(item.value == value)
                              end
                              selected_callback.call(value) if selected_callback
                            end
      @elements ||= []
      @ready = true
    end

    def elements=(enumerable)
      setup unless @ready
      delta = enumerable.length - @elements.length
      @height_factor = self.get_new_item.control.height unless @height_factor
      height = @elements.length
      delta.abs.times do
        if delta > 0
          item = self.get_new_item
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

    def selected
      return @elements.select { |element| element.selected == true}.first
    end

    def selected=(val)
      @elements.each do |element|
        element.set_selection(val == element.value)
      end
    end

    def get_new_item
      item = Freightrain[@viewmodel]
      item.signals.each do |key, signal|
        signal.connect(@signals[key]) if @signals[key]
      end
      return item
    end

    def bind(options)
      if options[:property].to_sym == :elements
        @viewmodel          = (options[:element].to_s + "_element_view_model").to_sym
        options[:force]     = true
      end
      super(options)
    end

  end

end
