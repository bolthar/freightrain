
class Generator

  def self.create_stub(filename, template, options)
    template_content = ""
    File.open(File.dirname(__FILE__) + "/templates/#{template}.ftt") do |file|
      template_content = file.lines.to_a.join
    end
    options.keys.each do |param|
      template_content.gsub!("$#{param}".upcase, "#{options[param]}")
    end
    File.open(filename, 'w+') do |file|
      file << template_content
    end
  end

end