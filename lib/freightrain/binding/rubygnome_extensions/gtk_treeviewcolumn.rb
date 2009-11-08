

module Gtk

  class TreeViewColumn

    attr_accessor :path
    
    attr_writer   :type

    def type
      return @type if @type
      return String
    end






  end

end
