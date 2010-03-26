require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe CallbackWrapper do

  describe "matches widget?" do

    it "should return false if widget name is not contained in method name" do
      method = stub(:name => "bau!!")
      result = CallbackWrapper.new(method).matches_widget?(stub(:name => "my_name"))
      result.should == false
    end

    it "should return true if widget name is after event name" do
      method = stub(:name => "on_test_my_name")
      result = CallbackWrapper.new(method).matches_widget?(stub(:name => "my_name"))
      result.should == false
    end

    it "should return true if widget name is before on" do
      method = stub(:name => "my_name_on_test")
      result = CallbackWrapper.new(method).matches_widget?(stub(:name => "my_name"))
      result.should == true
    end

    it "should return true if widget name is after on" do
      method = stub(:name => "on_my_name_test")
      result = CallbackWrapper.new(method).matches_widget?(stub(:name => "my_name"))
      result.should == true
    end

  end

  describe "event name" do

    it "should return tokens after widget name" do
      method = stub(:name => "on_my_name_test")
      result = CallbackWrapper.new(method).event_name(stub(:name => "my_name"))
      result.should == "test"
    end

    it "should replace _ with - " do
      method = stub(:name => "on_my_name_test_event")
      result = CallbackWrapper.new(method).event_name(stub(:name => "my_name"))
      result.should == "test-event"
    end
  end

end