
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FreightService do

  before :each do
    @class = Class.new(FreightService)
  end

  it "should extend ServiceHost" do    
    @class.kind_of? ServiceHost
  end  

end

