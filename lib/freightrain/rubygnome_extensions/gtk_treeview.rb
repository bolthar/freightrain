
module Freightrain

  class ListStoreConverter

    def from(columnset, enumerable)
      types = []
      types << Object
      #temporary : it will inject each column's type
      columnset.length.times do
        types << String
      end
      list_store = Gtk::ListStore.new(types)
        enumerable.each do |item|
        iterator = list_store.append
        iterator[0] = documento
        (1..columnset.length).each do |index|
          iterator[index] = item.send(columnset[index].path)
          columnset[index].attribute_set(columnset[index].cell_renderers[0], :text => index)
        end
      end
      return list_store
    end

  end
end

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

    end

  end
end
