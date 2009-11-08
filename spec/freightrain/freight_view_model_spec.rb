
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FreightViewModel do

  before :each do
    @class = Class.new(FreightViewModel)
  end

  after :each do
     #HACK: shouldn't be needed
    ContainerHookable.classes.clear #it avoids container specs to fail
  end

  it "should always extend ContainerHookable" do
    @class.kind_of?(ContainerHookable).should == true
  end

  it "should always extend ServiceHost" do
    @class.kind_of?(ServiceHost).should == true
  end

  it "should always extend RegionHost" do
    @class.kind_of?(RegionHost).should == true
  end

  it "should always extend SignalHost" do
    @class.kind_of?(SignalHost).should == true
  end


end
