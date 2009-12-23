
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe FreightService do

  before :each do
    @class = Class.new(FreightService)
  end

  it "should always extend ServiceHost" do
    @class.kind_of? ServiceHost
  end

  describe "ctor" do

    it "should always instantiate services" do
      Freightrain.stubs(:[]).with(:test_service).returns(1)
      @class.service(:test)
      service = @class.new
      service.instance_variable_get(:@test).should == 1
    end

  end

end

