
module Freightrain

  class GtkInterfaceBuilder

    def initialize
      @builder = Gtk::Builder.new
    end
    
    def add_from_file(file_path)
      @builder.add_from_file(file_path)
    end

    def objects
      return @builder.objects
    end

    def get_object(name)
      return @builder.get_object(name)
    end

    def connect_signals
      raise "You must provide a block to connect_signals" unless block_given?
      @builder.connect_signals do |signal|
        yield(signal)
      end
    end

  end
end
