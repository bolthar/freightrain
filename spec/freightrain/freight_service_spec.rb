
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FreightService do

  it "should do nothing if no service is added" do
    Freightrain.expects(:[]).never
    Class.new(FreightService).new
  end

  it "should call container for each service registered" do
    Freightrain.expects(:[]).with(:one_service)
    Freightrain.expects(:[]).with(:two_service)
    klass = Class.new(FreightService)
    klass.service(:one)
    klass.service(:two)
    klass.new
  end

  it "should add one service for each service registered" do
    Freightrain.stubs(:[]).returns(true)
    klass = Class.new(FreightService)
    klass.service(:one)
    klass.service(:two)
    instance = klass.new
    instance.instance_variable_get(:@one).should == true
    instance.instance_variable_get(:@two).should == true
  end

end

