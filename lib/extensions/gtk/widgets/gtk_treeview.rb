
module Gtk

  class TreeView

    def create_column(column_definition)
      renderer   = Gtk::CellRendererText.new
      title      = column_definition.keys.first
      attributes = {}
      column_definition.values.first.each do |binding|
        attributes[binding["property"]] = @paths[binding["path"]]
      end
      column     = Gtk::TreeViewColumn.new(title, renderer, attributes)
      self.append_column column
    end

    def bind(options)
      if options[:property].to_sym == :elements
        options[:force] = true
        columns = normalize_column_bindings(options[:columns])
        @paths  = get_paths(columns)
        columns.each do |column|
          create_column(column)
        end
      end
      super(options)
    end

    def elements=(enumerable)
      types = [::Object]
      @paths.length.times do
        types << String #TODO: allow for different types
      end
      list_store = Gtk::ListStore.new(*types)
      enumerable.each do |item|
        iterator = list_store.append
        iterator[0] = item
        @paths.each do |key, index|
          iterator[index] = item.send(key).to_s
        end
      end
      self.model = list_store
    end

    private
    def normalize_column_bindings(columns)
      result = []
      #step 1 : turn name/values only into arrays with 1 path
      columns.each do |col|
        unless col.values.first.kind_of?(Array)
          result << {col.keys.first => [{"path" => col.values.first}]}
        else
          result << col
        end
      end
      #step 2 : add property key if not present
      result.each do |col|
        col.values.first.each do |bindings|
          unless bindings["property"]
            bindings["property"] = "text"
          end
        end
      end
      return result
    end

    def get_paths(columns)
      paths = {}
      columns.each do |column|
        column.values.each do |binding|
          binding.each do |definition|
            paths[definition["path"]] = paths.length + 1 unless paths[definition["path"]]
          end
        end
      end
      return paths
    end

  end
  
end
