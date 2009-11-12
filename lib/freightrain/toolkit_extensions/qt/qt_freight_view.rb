
module Freightrain
  module QtExtensions

    class QtFreightView < FreightView

      def initialize(builder = QtExtensions::InterfaceBuilder.new)
        super(builder)
      end

      def toplevel
        return @builder.toplevel
      end

      def self.wrap_container(widget)
        return QtExtensions::RegionContainer.new(widget)
      end

    end
  end
end
