# To change this template, choose Tools | Templates
# and open the template in the editor.

module Freightrain

  module ContainerHookable

      def inherited(subclass)
        @subclasses ||= []
        @subclasses << subclass
      end

      def subclasses
        return @subclasses
      end   
      
  end

end
