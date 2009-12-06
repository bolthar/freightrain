

module Gtk

  class TreeView

    def create_text_column(name, path, index)
      p name
      p path
      p index
      renderer = Gtk::CellRendererText.new
      column = Gtk::TreeViewColumn.new(name, renderer, :text => index)
      column.path = path
      self.append_column column
    end

    def bind(options)
      if options[:property].to_sym == :elements
#        options[:force] = true
        (0...options[:columns].length).each do |index|
          create_text_column(
            options[:columns][index]['name'],
            options[:columns][index]['path'],
            index+1)
        end
      end
      super(options)
    end

    def elements=(enumerable)
      types = [::Object]
      types.concat columns.map { |column| column.type}
      list_store = Gtk::ListStore.new(*types)
      enumerable.each do |item|
        iterator = list_store.append
        iterator[0] = item
        (0...columns.length).each do |index|
          iterator[index+1] = item.send(columns[index].path.to_s)
        end
      end
      self.model = list_store
    end

  end
end
