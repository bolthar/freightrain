
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

  describe "each_binding" do

    it "should not yield if filename is nil" do
      loader = BindingLoader.new("Noclass")
      loader.each_binding do
        raise "never yield"
      end
    end

    it "should not yield if YAML.load returns false" do
      loader = BindingLoader.new("MyClass")
      Dir.stubs(:glob).returns([1])
      YAML.stubs(:load_file).returns(false)
      loader.each_binding do
        raise "never yield"
      end
    end

    it "should yield once if only one binding in file" do
      times = 0
      loader = BindingLoader.new("MyClass")
      Dir.stubs(:glob).returns([1])
      YAML.stubs(:load_file).returns({:widget => {:dummy => true}})
      loader.each_binding do
        times += 1
      end
      times.should == 1
    end

    it "should yield twice if two bindings in file" do
      times = 0
      loader = BindingLoader.new("MyClass")
      Dir.stubs(:glob).returns([1])
      YAML.stubs(:load_file).returns({:widget => [{:dummy => true}, {:dummy => true}]})
      loader.each_binding do
        times += 1
      end
      times.should == 2
    end

    it "should always yield with right options" do
      loader = BindingLoader.new("MyClass")
      Dir.stubs(:glob).returns([1])
      YAML.stubs(:load_file).returns({:widget => {:opt1 => "a", :opt2 => "b"}})
      loader.each_binding do |widget_name, options|
        options[:opt1].should == "a"
        options[:opt2].should == "b"
      end
    end

    it "should always yield with right widget name" do
      loader = BindingLoader.new("MyClass")
      Dir.stubs(:glob).returns([1])
      YAML.stubs(:load_file).returns({:my_name => {:opt1 => "a", :opt2 => "b"}})
      loader.each_binding do |widget_name, options|
        widget_name.should == :my_name
      end
    end

  end
end

