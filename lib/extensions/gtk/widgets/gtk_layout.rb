
module Gtk

  class Layout
    include Freightrain::LayoutWidget

    attr_writer :viewmodel
    attr_reader :elements
    
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
      @height_factor = Freightrain[@viewmodel].control.height_request unless @height_factor
      height = @elements.length
      delta.abs.times do
        if delta > 0
          item = Freightrain[@viewmodel]
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
      (0...@elements.length).each do |index|
        @elements[index].value = enumerable[index]
      end
    end

    def bind(options)
      if options[:property].to_s == "elements"
        @viewmodel          = (options[:element].to_s + "_element_view_model").to_sym
        options[:force]     = true
      end
      super(options)
    end
      
  end

end

