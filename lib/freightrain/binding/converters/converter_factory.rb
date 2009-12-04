
module Freightrain

  class ConverterFactory

    def self.create(converter_name)
      name = converter_name.to_s.capitalize
      #first try to get one of the standard converters
      if Freightrain.const_defined? "#{name}Converter"
        return Freightrain.const_get("#{name}Converter").new
      end
      #then, if not found, try to get a registered custom converter
      converter = Freightrain["#{name}Converter".to_convention_sym] rescue nil
      #if nothing found, give up (converter is nil il registry throws)
      return converter
    end

  end

end
