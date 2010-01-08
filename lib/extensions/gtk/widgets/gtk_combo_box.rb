
module Gtk

  class ComboBox

    def elements=(enumerable)
      list_store = Gtk::ListStore.new(::Object, String)
      enumerable.each do |item|
        iterator = list_store.append        
        iterator[0] = item
        iterator[1] = item.send(@text)
      end
      self.model = list_store
    end

    def selected
      iter = self.model.selection.selected
      return iter[0] if iter
    end

    def selected=(object)
      if self.model
        self.model.each do |model, path, iter|
          self.active_iter = iter if iter[0] == object
        end
      end
    end

    def bind(options)
      if options[:property].to_sym == :elements
        @path = options[:path]
        @text = options[:text] || "to_s"
        renderer = Gtk::CellRendererText.new
        self.pack_start(renderer, true)
        self.add_attribute(renderer,:text, 1)
      end
      super(options)
    end

  end
end