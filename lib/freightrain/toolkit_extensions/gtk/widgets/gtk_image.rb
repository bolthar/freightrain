
module Gtk

  class Image

    def bind(options)
      if options[:property] == :pixbuf
        options[:converter] = PixbufConverter.new
      end
      super(options)
    end


  end
end