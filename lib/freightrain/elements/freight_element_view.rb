
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
      #should be overridden
    end

    def initialize
      super
      @signals[:selected] = FreightSignal.new
    end

  end
end
