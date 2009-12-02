

module Freightrain

  class FreightElementViewModel < FreightViewModel
    extend ContainerHookable

    def value=(val)
      @data.value = val
    end

    def value
      return @data.value
    end

    def on_selected
      fire :selected, @data
    end

    def control
      return @view.control
    end

    def initialize
      super
      @signals[:selected] = FreightSignal.new
    end

    def set_selection(bool)
      @view.set_ui_selection(bool)
    end

  end

end