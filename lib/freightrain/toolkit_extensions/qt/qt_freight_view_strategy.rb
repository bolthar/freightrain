
module Freightrain
  module QtExtensions

    class QtFreightViewToolkit

      def builder
        @builder = QtExtensions::InterfaceBuilder.new
        return @builder
      end

      def wrap_container(widget)
        return QtExtensions::RegionContainer.new(widget)
      end

      def toplevel
        return @builder.toplevel
      end

      def widgets
        return @builder.widgets
      end

    end
  end
end
