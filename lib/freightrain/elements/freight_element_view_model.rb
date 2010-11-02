
module Freightrain

  #TODO: make this an extension
  class FreightElementViewModel < FreightViewModel
    extend ContainerHookable

    attr_reader :selected

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
      @view.update
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