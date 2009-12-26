
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe LayoutWidget do

  before :each do
    @class = Class.new
    @class.instance_eval("include LayoutWidget")
  end

  describe "add signal callback" do

    it "should add the specified proc to target signal" do
      instance = @class.new
      my_proc = lambda { "dummy" }
      instance.add_signal_callback(:test, my_proc)
      instance.instance_variable_get(:@signals)[:test].should == my_proc
    end

    it "should keep adding signals after first" do
      instance = @class.new
      my_proc = lambda { "dummy" }
      my_proc_2 = lambda { "dummy2" }
      instance.add_signal_callback(:test, my_proc)
      instance.add_signal_callback(:test2, my_proc_2)
      instance.instance_variable_get(:@signals)[:test].should == my_proc
      instance.instance_variable_get(:@signals)[:test2].should == my_proc_2
    end

    it "should overwrite old proc when given existing key" do
      instance = @class.new
      my_proc = lambda { "dummy" }
      my_proc_new = lambda { "dummy2" }
      instance.add_signal_callback(:test, my_proc)
      instance.add_signal_callback(:test, my_proc_new)
      instance.instance_variable_get(:@signals)[:test].should == my_proc_new
    end
  end

end

