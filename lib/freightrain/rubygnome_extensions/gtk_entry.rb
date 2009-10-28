
module Gtk

  class Entry

    def bind(path)
      options = {:property => :text, :path => path.to_sym} if path.kind_of? String
      options = path if path.kind_of? Hash
      super(options)
    end
  end
end