
class Generator

  def self.create_stub(filename, template, options)
    template_content = ""
    File.open(File.dirname(__FILE__) + "/templates/#{template}.ftt") do |file|
      template_content = file.lines.to_a.join
    end
    template_content.gsub!("$NAME", options[:name])
    File.open(filename, 'w+') do |file|
      file << template_content
    end
  end

end