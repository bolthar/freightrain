
module Freightrain

  class FreightElementView < FreightView
    extend ContainerHookable

    def self.container_options
      return { :model => :prototype }
    end

    def update
      @signals.values.each { |signal| signal.stifle }
      super
      @signals.values.each { |signal| signal.unleash }
    end
    
    def initialize
      super
      @signals[:selected] = FreightSignal.new
    end

  end
end
