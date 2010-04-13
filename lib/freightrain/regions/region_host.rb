
module RegionHost

  def self.extended(klass)

    klass.class_eval do

      def build_regions
        region_definitions = self.class.instance_variable_get(:@regions)
        region_definitions ||= []
        @regions = {}
        region_definitions.each do |name, options|
          @regions[name] = FreightRegion.new(name, options)
          self.class.send(:define_method, name) do
            return @regions[name].viewmodel
          end
          @regions[name].connect_to(self)
        end
      end

      def change_region(region_name, viewmodel_name)
        region = FreightRegion.new(region_name, {:viewmodel => viewmodel_name})
        region.connect_to(self)
        region.on_show(@view)
        @regions[region_name] = region
      end

    end

  end

  def region(name, options = {})
    @regions ||= {}
    @regions[name.to_sym] = options
  end

end

