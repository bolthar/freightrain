
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require File.dirname(__FILE__) + '/../../../lib/freightrain/ioc/container_hookable.rb'
require File.dirname(__FILE__) + '/../../../lib/freightrain/ioc/container.rb'
require File.dirname(__FILE__) + '/../../../lib/freightrain/string_patch.rb'
require 'rubygems'
require 'mocha'

Spec::Runner.configure do |config|
    config.mock_with :mocha
end

include Freightrain

describe Freightrain do

  before :each do
    ContainerHookable.classes.clear
  end

  describe "configure container!" do

    it "should call register on container once for every subclass" do
      klass_one = Class.new().class_eval("extend ContainerHookable")
      klass_two = Class.new().class_eval("extend ContainerHookable")
      Class.new(klass_one)
      Class.new(klass_two)
      Class.new(klass_two)
      registry = mock()
      registry.expects(:register).times(3)
      Freightrain.configure_container!(registry)
      ContainerHookable.classes.clear
    end

  end

  describe "indexer" do

    it "should raise if container is not initialized" do
      lambda do
        Freightrain[:not_initialized]
      end.should raise_error
    end

    it "should return registered service if present" do
      registry = stub()
      registry.stubs(:send).with(:registered_service).returns(1)
      Freightrain.configure_container!(registry)
      Freightrain[:registered_service].should == 1
    end

    it "should throw if requested service is not registered" do
      registry = stub()
      Freightrain.configure_container!(registry)
      lambda do
        Freightrain[:registered_service]
      end.should raise_error
    end


  end

end

