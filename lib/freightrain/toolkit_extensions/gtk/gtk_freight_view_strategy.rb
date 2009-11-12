
module Freightrain
  module GtkExtensions

    class GtkFreightViewToolkit

      def builder
        @builder = GtkExtensions::InterfaceBuilder.new
        return @builder
      end

      def widgets
        return @builder.widgets
      end

      def toplevel
        return @builder.widgets.first.toplevel
      end

      def self.wrap_container(widget)
        return GtkExtensions::RegionContainer.new(widget)
      end

    end
  end
end
