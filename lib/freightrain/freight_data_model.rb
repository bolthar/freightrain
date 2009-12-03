
module Freightrain
  
  class FreightDataModel
    extend ContainerHookable

    def self.container_options
      return { :model => :prototype }
    end
    
  end

end

