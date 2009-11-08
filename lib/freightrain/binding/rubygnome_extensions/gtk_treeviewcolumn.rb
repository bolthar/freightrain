

module Gtk

  class TreeViewColumn

    attr_accessor :path
    attr_accessor :type

    def initialize(title, renderer, options)
      super(title, renderer, options)
      @type = String
    end    

  end

end
