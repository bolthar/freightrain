
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Freightrain do

  describe "auto_require!" do

    before :each do
      Freightrain.app_path = "testpath"
      Freightrain.stubs(:require_all)
    end
     
    it "should call require_all for views folder" do 
      Freightrain.expects(:require_all).with("testpath/views")
      Freightrain.auto_require!
    end

    it "should call require_all for viewmodels folder" do
      Freightrain.expects(:require_all).with("testpath/viewmodels")
      Freightrain.auto_require!
    end

    it "should call require_all for services folder" do
      Freightrain.expects(:require_all).with("testpath/services")
      Freightrain.auto_require!
    end

    it "should call require_all for domain folder" do 
      Freightrain.expects(:require_all).with("testpath/domain")
      Freightrain.auto_require!
    end

  end

end
