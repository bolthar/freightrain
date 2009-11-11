
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Freightrain do

  describe "auto_require!" do

    before :each do
      Freightrain.app_path = "testpath"
      Freightrain.stubs(:require_all)
      File.stubs(:directory?).returns(false)
      Dir.stubs(:entries).returns(false)
    end
     
    it "should call require_all for views folder" do 
      Freightrain.expects(:require_all).with("testpath/views")
      Freightrain.auto_require!
    end

    it "should call require_all for viewmodels folder" do
      Freightrain.expects(:require_all).with("testpath/viewmodels")
      Freightrain.auto_require!
    end

    it "should call require_all for services folder if exists and contains files" do
      File.stubs(:directory?).with("testpath/services").returns(true)
      Dir.stubs(:entries).with("testpath/services").returns([1])
      Freightrain.expects(:require_all).with("testpath/services")
      Freightrain.auto_require!
    end

    it "should not call require_all for services folder if does not exist" do
      Freightrain.expects(:require_all).with("testpath/services").never
      Freightrain.auto_require!
    end

    it "should not call require_all for services folder if folder is empty" do
      File.stubs(:directory?).with("testpath/services").returns(true)
      Dir.stubs(:entries).with("testpath/services").returns([])
      Freightrain.expects(:require_all).with("testpath/services").never
      Freightrain.auto_require!
    end

    it "should call require_all for domain folder" do
      File.stubs(:directory?).with("testpath/domain").returns(true)
      Dir.stubs(:entries).with("testpath/domain").returns([1])
      Freightrain.expects(:require_all).with("testpath/domain")
      Freightrain.auto_require!
    end

    it "should not call require_all for domain folder if does not exist" do
      Freightrain.expects(:require_all).with("testpath/domain").never
      Freightrain.auto_require!
    end

    it "should not call require_all for domain folder if folder is empty" do
      File.stubs(:directory?).with("testpath/domain").returns(true)
      Dir.stubs(:entries).with("testpath/domain").returns([])
      Freightrain.expects(:require_all).with("testpath/domain").never
      Freightrain.auto_require!
    end

  end

end
