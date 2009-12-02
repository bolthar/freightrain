
module Freightrain
  
  class FreightDataModel
    extend ContainerHookable

    def container_options
      return { :model => :prototype }
    end
    
  end

end

