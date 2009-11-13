
module Freightrain

  class FreightElementView < FreightView
    
    def value
      return @value
    end

    def value=(val)
      @value = val
    end

    def control
      return toplevel
    end

    def set_ui_selection(bool)
      @signals.values.each { |s| s.stifle }
      selected(bool)
      @signals.values.each { |s| s.unleash }
    end

    def selected(bool)
      raise "selected is not overridden. You should override the selected method on your #{self.class.name} control"
    end

    def initialize(builder = nil)
      super(builder)
      @signals[:selected] = FreightSignal.new
    end

  end
end
