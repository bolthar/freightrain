

module Gtk

  class TreeViewColumn

    attr_accessor :path

    attr_writer   :property
    attr_writer   :type

    def type
      return @type if @type
      return String
    end

    def property
      return @property if @property
      return :text
    end






  end

end
