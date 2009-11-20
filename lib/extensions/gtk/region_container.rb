

module Freightrain

  module Toolkit

    class RegionContainer

      def initialize(widget)
        @widget = widget
      end

      def plug_in(region_widget)
        @widget.remove(@widget.children.first)
        @widget << region_widget
      end
      
    end
  end
end