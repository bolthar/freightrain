
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
      service_stub = stub(:signals => [])
      Freightrain.stubs(:[]).with(:test_service).returns(service_stub)
      @class.service(:test)
      service = @class.new
      service.instance_variable_get(:@test).should == service_stub
    end

    it "should hook to service's signal if method is implemented" do
      signal_mock  = mock(:connect => nil)
      service_stub = stub(:signals => {:test_signal => signal_mock})
      Freightrain.stubs(:[]).with(:test_service).returns(service_stub)
      @class.service(:test)
      @class.class_eval do
        def test_on_test_signal
          # do nothing
        end
      end
      service = @class.new
    end

  end

end

