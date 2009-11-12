
module Freightrain
  module GtkExtensions

    class GtkFreightView < FreightView

      def initialize(builder = GtkExtensions::InterfaceBuilder.new)
        super(builder)
      end

      def toplevel
        return @widgets.first.toplevel
      end

      def self.wrap_container(widget)
        return GtkExtensions::RegionContainer.new(widget)
      end

    end
  end
end
