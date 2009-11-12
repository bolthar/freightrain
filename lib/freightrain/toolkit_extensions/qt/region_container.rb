
module Freightrain

  module QtExtensions

    class RegionContainer

      def initialize(widget)
        @widget = widget
      end

      def plug_in(region_widget)
        region_widget.setParent(@widget)
        region_widget.show
      end
      
    end
  end
end