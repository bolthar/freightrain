
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "bootstrapper" do

  after :each do
    Freightrain.toolkit = nil
  end

  describe "views path" do

    it "should return app_path + views if toolkit_path does not exists" do
      Freightrain.app_path = "testpath"
      Freightrain.views_path.should == "testpath/views"
    end

    it "should return app_path + toolkit_path + views if toolkit_path exists" do
      Freightrain.app_path = "testpath"
      Freightrain.toolkit = :toolkit
      File.stubs(:exist?).with("testpath/views/toolkit").returns(true)
      Freightrain.views_path.should == "testpath/views/toolkit"
    end

  end

  describe "load extensions!" do

    it "should call require with right parameters" do
      File.stubs(:dirname).returns("testdir")
      Freightrain.toolkit = :toolkit
      Freightrain.expects(:require).with("testdir/../extensions/toolkit/toolkit_bootstrapper.rb")
      Freightrain.load_extensions!
    end

    it "should not raise on exceptions" do
      Freightrain.load_extensions!
    end

  end

  describe "start" do

    before :each do
      Freightrain.stubs(:load_extensions!)
      Freightrain.stubs(:auto_require!)
      Freightrain.stubs(:configure_container!)
      Freightrain::Toolkit = stub()
      Freightrain::Toolkit.stubs(:start_main_loop)
    end

    it "should call load extensions!" do
      Freightrain.expects(:load_extensions!)
      Freightrain.start(:test)
    end

    it "should call auto require!" do
      Freightrain.expects(:auto_require!)
      Freightrain.start(nil)
    end

    it "should call configure container!" do
      Freightrain.expects(:configure_container!)
      Freightrain.start(nil)
    end

    it "should yield block if block given" do
      called = false
      Freightrain.start(nil) do
        called = true
      end
      called.should == true
    end

    it "should not raise if block not given" do
      Freightrain.start(nil)
    end

    it "should call start main loop on toolkit" do
      Toolkit.expects(:start_main_loop)
      Freightrain.start(nil)
    end

  end

end

