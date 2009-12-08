
module RegionHost

  def self.extended(klass)

    klass.class_eval do

      def build_regions
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

      def change_region(region_name, viewmodel_name)
        @regions[region_name] = FreightRegion.new(region_name, {:viewmodel => viewmodel_name})
        @regions[region_name].viewmodel.signals.each do |key, signal|
          signal.connect(method("#{region_name.to_s}_on_#{key.to_s}".to_sym)) if self.respond_to? "#{region_name.to_s}_on_#{key.to_s}".to_sym
        end
        @regions[region_name].on_show(@view)
      end

    end

  end

  def region(name, options = {})
    @regions ||= {}
    @regions[name.to_sym] = options
  end

end
