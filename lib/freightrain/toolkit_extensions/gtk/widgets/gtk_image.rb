
module Gtk

  class Image

    def image=(value)
      file = File.new(File.join(Dir.tmpdir,"tempimg#{self.object_id.to_s}"),'w')
      file << value
      file.close
      return Gdk::Pixbuf.new(File.join(Dir.tmpdir,"tempimg#{self.object_id.to_s}"))
    end
    
  end
end