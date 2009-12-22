
module RegionHost

  def self.extended(klass)

    klass.class_eval do

      def build_regions
        regions = self.class.instance_variable_get(:@regions)
        regions ||= []
        @regions = {}
        regions.each do |name, options|
          @regions[name] = FreightRegion.new(name, options)
          self.class.send(:define_method, name) do
            return @regions[name].viewmodel
          end
          @regions[name].connect_to(self)
        end        
      end

      def change_region(region_name, viewmodel_name)
        @regions[region_name] = FreightRegion.new(region_name, {:viewmodel => viewmodel_name})
        @regions[region_name].connect_to(self)
        @regions[region_name].on_show(@view)
      end

    end
    
  end

  def region(name, options = {})
    @regions ||= {}
    @regions[name.to_sym] = options
  end

end
