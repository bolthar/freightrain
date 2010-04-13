
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe RegionHost do

  before :each do
    @class = Class.new()
    @class.extend(RegionHost)
  end

  it "should add a 'build_regions' method on istances when extended" do
    instance = @class.new
    (instance.respond_to? :build_regions).should == true
  end

  it "should add a 'change_region' method on istances when extended" do
   instance = @class.new
   (instance.respond_to? :change_region).should == true
  end

  describe "region" do

    it "should create and to region definitions first time is called" do
      @class.region(:test)
      @class.instance_variable_get(:@regions).length.should == 1
    end

    it "should add one region definition each time is called" do
      @class.region(:bar)
      @class.region(:foo)
      @class.instance_variable_get(:@regions).length.should == 2
    end

    it "should add the 'name' key to region definitions hash" do
      @class.region(:foo)
      @class.instance_variable_get(:@regions).keys.include?(:foo).should == true
    end

    it "should add the options provided to the hash accordingly" do
      @class.region(:foo, :bar)
      @class.instance_variable_get(:@regions)[:foo].should == :bar
    end

  end

  describe "build regions" do

    it "should not build regions if no region is declared" do
      FreightRegion.expects(:new).never
      @class.new.build_regions
    end

    it "should call FreightRegion.new with right params if region defined" do
      @class.instance_variable_set(:@regions, {:foo => :bar})
      FreightRegion.expects(:new).with(:foo, :bar).returns(stub_everything)
      @class.new.build_regions
    end

    it "should call connect_to on regions created" do
      @class.instance_variable_set(:@regions, {:foo => :bar})
      region = mock(:connect_to)
      FreightRegion.stubs(:new).with(:foo, :bar).returns(region)
      @class.new.build_regions
    end

    it "should create an helper method for the region" do
      @class.instance_variable_set(:@regions, {:foo => :bar})
      FreightRegion.stubs(:new).with(:foo, :bar).returns(stub_everything)
      instance = @class.new
      instance.build_regions
      instance.respond_to?(:foo).should == true
    end

    describe "helper method" do

      it "should always return target region's viewmodel" do
        @class.instance_variable_set(:@regions, {:foo => :bar})
        region = stub(:viewmodel => 1, :connect_to => nil)
        FreightRegion.stubs(:new).with(:foo, :bar).returns(region)
        instance = @class.new
        instance.build_regions
        instance.foo.should == 1
      end

    end
    
  end

  describe "change region" do

    before :each do
      @instance = @class.new
      @instance.instance_variable_set(:@regions, {})
    end

    it "should call FreightRegion.new with right params" do
      FreightRegion.expects(:new).with(:foo, {:viewmodel => :bar}).returns(stub_everything)
      @instance.change_region(:foo, :bar)
    end

    it "should call connect_to on region with self" do
      region = stub_everything()
      region.expects(:connect_to).with(@instance)
      FreightRegion.stubs(:new).returns(region)
      @instance.change_region(:foo, :bar)
    end

    it "should call on_show on region with view param" do
      region = stub_everything()
      @instance.instance_variable_set(:@view, 1)
      region.expects(:on_show).with(1)
      FreightRegion.stubs(:new).returns(region)
      @instance.change_region(:foo, :bar)
    end

    it "should set the new region in place of the old one" do
      region = stub_everything()
      FreightRegion.stubs(:new).returns(region)
      @instance.change_region(:foo, :bar)
      @instance.instance_variable_get(:@regions)[:foo].should == region
    end

  end

end