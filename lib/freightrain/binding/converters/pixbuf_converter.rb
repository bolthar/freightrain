

module Freightrain

  class PixbufConverter

    def initialize(identifier = self.object_id)
      @identifier = identifier
    end

    def from(value)
      file = File.new(File.join(Dir.tmpdir,"tempimg#{@identifier}.jpg"),'w')
      file << value
      file.close
      return Gdk::Pixbuf.new(File.join(Dir.tmpdir,"tempimg#{@identifier}.jpg"))
    end

  end
end