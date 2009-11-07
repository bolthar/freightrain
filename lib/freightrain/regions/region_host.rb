
module RegionHost

  def build_regions
    regions = self.class.instance_variable_get(:@regions)
    regions ||= []
    @regions = {}
    regions.each do |name, options|
      @regions[name] = FreightRegion.new(name, options)
    end
  end

    
end
