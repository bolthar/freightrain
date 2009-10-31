
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Freightrain do

  describe "auto require!" do

    before :each do
      File.stubs(:join)
      Dir.stubs(:glob).returns([])
    end

    it "should raise if APP_PATH is not set" do
      lambda do 
        Freightrain.auto_require!
      end.should raise_error
    end

    it "should call require for every rb file in views" do
      Freightrain.app_path = "testpath"
      File.stubs(:join).with("testpath", "views", "**/*.rb").returns("viewspath")
      Dir.stubs(:glob).with("viewspath").returns(["file1","file2"])
      Freightrain.expects(:require).with("file1")
      Freightrain.expects(:require).with("file2")
      Freightrain.auto_require!
    end

    it "should call require for every rb file in viewmodels" do
      Freightrain.app_path = "testpath"
      File.stubs(:join).with("testpath", "views", "**/*.rb").returns("viewsmodelpath")
      Dir.stubs(:glob).with("viewsmodelpath").returns(["file1","file2"])
      Freightrain.expects(:require).with("file1")
      Freightrain.expects(:require).with("file2")
      Freightrain.auto_require!
    end

    it "should call require for every rb file in services" do
      Freightrain.app_path = "testpath"
      File.stubs(:join).with("testpath", "views", "**/*.rb").returns("servicespath")
      Dir.stubs(:glob).with("servicespath").returns(["file1","file2"])
      Freightrain.expects(:require).with("file1")
      Freightrain.expects(:require).with("file2")
      Freightrain.auto_require!
    end

    it "should call require for every rb file in domain" do
      Freightrain.app_path = "testpath"
      File.stubs(:join).with("testpath", "views", "**/*.rb").returns("modelspath")
      Dir.stubs(:glob).with("modelspath").returns(["file1","file2"])
      Freightrain.expects(:require).with("file1")
      Freightrain.expects(:require).with("file2")
      Freightrain.auto_require!
    end

  end
end

