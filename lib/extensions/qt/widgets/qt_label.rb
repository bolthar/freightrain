

module Qt

  class Label

    def image=(value)
      file = ::File.new(::File.join(::Dir.tmpdir,"tempimg#{self.object_id.to_s}"),'w')
      file << value
      file.close
      image = Qt::Image.new(::File.join(::Dir.tmpdir,"tempimg#{self.object_id.to_s}"))
      self.pixmap = image
      self.resize(self.pixmap.size)
    end
    
  end

end
