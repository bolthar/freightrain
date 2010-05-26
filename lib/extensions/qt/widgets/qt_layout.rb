
module Qt

  class VBoxLayout
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
      @elements.each do |item|
        self.removeWidget(item.control)
        item.control.dispose
      end
      @elements.clear
      enumerable.each do |value|
        item = self.get_new_item
        item.value = value
        self.addWidget(item.control)
        item.control.show
        @elements << item
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