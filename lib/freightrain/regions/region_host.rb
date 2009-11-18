
module RegionHost

  def self.extended(klass)
    klass.send(:define_method, :build_regions) do
      regions = self.class.instance_variable_get(:@regions)
      regions ||= []
      @regions = {}
      regions.each do |name, options|
        @regions[name] = FreightRegion.new(name, options)
        klass.send(:define_method, name) do
          return @regions[name].viewmodel
        end
      end
    end


  end

  def region(name, options = {})
    @regions ||= {}
    @regions[name.to_sym] = options
  end

end
