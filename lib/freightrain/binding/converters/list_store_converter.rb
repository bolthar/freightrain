
module Freightrain

  class ListStoreConverter

    def initialize(columns)
      @columns = columns
    end

    def from(enumerable)
      types = []
      types << Object
      #temporary : it will inject each column's type
      @columns.length.times do
        types << String
      end
      list_store = Gtk::ListStore.new(*types)
      enumerable.each do |item|
        iterator = list_store.append
        iterator[0] = item
        (0...@columns.length).each do |index|
          iterator[index+1] = item.send(@columns[index].path)
          @columns[index].set_attributes(@columns[index].cell_renderers[0], :text => index+1)
        end
      end
      return list_store
    end

  end
end