
module Freightrain

  #TODO: make this an extension or even remove it
  class FreightElementView < FreightView
    extend ContainerHookable

    def self.container_options
      return { :model => :prototype }
    end

    def initialize
      super
      @signals[:selected] = FreightSignal.new
    end

  end
end
