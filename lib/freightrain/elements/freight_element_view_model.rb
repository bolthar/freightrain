

module Freightrain

  class FreightElementViewModel < FreightViewModel
    extend ContainerHookable

    def self.container_options
      return { :model => :prototype }
    end

    def value=(val)
      @value = val
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
      @selected = bool
      @view.update
    end

  end

end