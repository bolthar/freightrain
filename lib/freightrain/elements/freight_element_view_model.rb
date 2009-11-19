

module Freightrain

  class FreightElementViewModel < FreightViewModel
    extend ContainerHookable

    def self.container_options
      return {:model => :prototype }
    end

    def value=(val)
      @value = val
      p val.name if val
      p "nil value" if !val
      @view.update
    end

    def value
      return @value
    end

    def on_selected
      fire :selected, @value
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