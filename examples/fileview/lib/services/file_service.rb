
class FileService < FreightService

  def load_file(filename)
    return "file #{filename} not found" unless File.exist?(filename)
    return File.readlines(filename).join
  end
end