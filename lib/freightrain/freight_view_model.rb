# To change this template, choose Tools | Templates
# and open the template in the editor.

module Freightrain

  class FreightViewModel
    extend ContainerHookable

    def initialize()
      @view = Freightrain[self.class.name.sub("Model","").to_convention_sym]
      @view.signals.each do |key,signal|       
        signal.connect(method("on_" + key.to_s)) if self.respond_to? "on_" + key.to_s
      end      
    end

    def show
      @view.toplevel.visible = true
    end

  end
end
