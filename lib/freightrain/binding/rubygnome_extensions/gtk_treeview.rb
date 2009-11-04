

module Gtk

  class TreeView

    def bind(options)
      if options[:property] == :model
        options[:converter] ||= default_converter
      end
      super(options)
    end

    private
    def default_converter
      return Freightrain::ListStoreConverter.new(columns)
    end

  end
end
