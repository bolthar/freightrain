

module Gtk

  class TreeViewColumn

    attr_accessor :path
    attr_accessor :type

    def initialize
      super
      @type = String
    end    

  end

end
