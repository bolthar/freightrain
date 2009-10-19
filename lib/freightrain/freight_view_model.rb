# To change this template, choose Tools | Templates
# and open the template in the editor.

module Freightrain
  class FreightViewModel

    def initialize(view = nil)
      if view
        @view = view
      else        
        @view = eval("#{self.class.name.sub("Model","")}.new")
      end     
      @view.signals.each do |key,signal|       
        signal.connect(method("on_" + key.to_s)) if self.respond_to? "on_" + key.to_s
      end      
    end

  end
end
