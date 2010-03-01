
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ServiceHost do
  
  it "should do nothing if no service is added" do
    Freightrain.expects(:[]).never
    Class.new(FreightService).new
  end

  it "should call container for each service registered" do
    Freightrain.expects(:[]).with(:one_service).returns(stub(:signals => []))
    Freightrain.expects(:[]).with(:two_service).returns(stub(:signals => []))
    klass = Class.new(FreightService)
    klass.service(:one)
    klass.service(:two)
    klass.new
  end

  it "should add one service for each service registered" do
    stub_service = stub(:signals => [])
    Freightrain.stubs(:[]).returns(stub_service)
    klass = Class.new(FreightService)
    klass.service(:one)
    klass.service(:two)
    instance = klass.new
    instance.instance_variable_get(:@one).should == stub_service
    instance.instance_variable_get(:@two).should == stub_service
  end

end

