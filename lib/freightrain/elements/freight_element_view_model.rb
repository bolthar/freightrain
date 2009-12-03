

module Freightrain

  class FreightElementViewModel < FreightViewModel
    extend ContainerHookable

    def self.container_options
      return { :model => :prototype }
    end

    def value=(val)
      @data.value = val if @data
    end

    def value
      return @data.value if @ðata
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