
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe BindingLoader do
  
  before :each do
    Freightrain.app_path = "testpath"
  end

  describe "filename" do

    it "should return nil if dir does not contain file" do
      loader = BindingLoader.new("Noclass")
      loader.filename.should == nil
    end

    it "should call dir.glob with right parameter" do
      loader = BindingLoader.new("TestView")
      Dir.expects(:glob).with("testpath/views/**/test_view.bnd.yml").returns([])
      loader.filename
    end

    it "should return the first result if dir contains at least one file" do
      loader = BindingLoader.new("TestView")
      Dir.stubs(:glob).with("testpath/views/**/test_view.bnd.yml").returns([1,2])
      filename = loader.filename
      filename.should == 1
    end

  end
end

