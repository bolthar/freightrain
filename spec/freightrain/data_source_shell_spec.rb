
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DataSourceShell do

  describe "get" do

    it "should return property if path is first level" do
      source = stub()
      source.stubs(:send).with("value").returns("okay")
      shell = DataSourceShell.new(source)
      shell.get(["value"]).should == "okay"
    end

    it "should dig one layer if path is second level" do
      level_2 = stub()
      level_2.stubs(:send).with("value").returns("okay")
      source = stub()
      source.stubs(:send).with("child").returns(level_2)
      shell = DataSourceShell.new(source)
      shell.get(["child","value"]).should == "okay"
    end
    
  end

  describe "set" do

    it "should set property if path is first level" do
      source = stub()
      source.expects(:send).with("value=", :value)
      shell = DataSourceShell.new(source)
      shell.set(["value"], :value)
    end

    it "should dig one layer if path is second level" do
      level_2 = stub()
      level_2.expects(:send).with("value=", :value)
      source = stub()
      source.stubs(:send).with("child").returns(level_2)
      shell = DataSourceShell.new(source)
      shell.set(["child","value"], :value)
    end

  end


end

