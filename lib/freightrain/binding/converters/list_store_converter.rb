
module Freightrain

  class ListStoreConverter

    def initialize(columns)
      @columns = columns
      (0...@columns.length).each do |index|
        @columns[index].set_attributes(
          @columns[index].cell_renderers[0],
          @columns[index].property => index+1)
      end
    end

    def from(enumerable)
      types = [Object]
      types.concat @columns.map { |column| column.type}
      list_store = Gtk::ListStore.new(*types)
      enumerable.each do |item|
        iterator = list_store.append
        iterator[0] = item
        (0...@columns.length).each do |index|
          iterator[index+1] = item.send(@columns[index].path)         
        end
      end
      return list_store
    end

  end
end