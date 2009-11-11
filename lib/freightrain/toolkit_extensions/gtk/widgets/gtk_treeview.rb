

module Gtk

  class TreeView

    def bind(options)
      if options[:property] == :model
        options[:converter] ||= ListStoreConverter.new(columns)
      end
      super(options)
    end

  end
end
