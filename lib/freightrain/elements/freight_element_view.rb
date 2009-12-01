
module Freightrain

  class FreightElementView < FreightView
    extend ContainerHookable

    def self.container_options
      return { :model => :prototype }
    end
    
    def set_ui_selection(bool)
      @signals.values.each { |s| s.stifle }
      selected(bool)
      @signals.values.each { |s| s.unleash }
    end

    def selected(bool)
      raise "selected is not overridden. You should override the selected method on your #{self.class.name} control"
    end

    def initialize
      super
      @signals[:selected] = FreightSignal.new
    end

  end
end
