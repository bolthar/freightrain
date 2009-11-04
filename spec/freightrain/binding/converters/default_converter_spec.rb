
require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe DefaultConverter do

  describe "from" do

    it "should return same value passed" do
      DefaultConverter.new.from(:test).should == :test
    end

  end

  describe "to" do

    it "should return same value passed" do
      DefaultConverter.new.to(:test).should == :test
    end

  end

end

