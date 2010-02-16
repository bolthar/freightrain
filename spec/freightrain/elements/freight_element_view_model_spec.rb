
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe FreightElementViewModel do

  before :each do
    @view = stub()
    @view.stubs(:signals).returns([])
    @view.stubs(:data_source=)
    Freightrain.stubs(:[]).with(:test_element_view).returns(@view)
  end

  it "should always have a 'selected' signal" do    
    TestElementViewModel = Class.new(FreightElementViewModel)
    instance = TestElementViewModel.new
    instance.signals[:selected].should be_a_kind_of(FreightSignal)
  end

  it "should always extend ContainerHookable" do
    klass = Class.new(FreightElementViewModel)
    klass.kind_of?(ContainerHookable).should == true
  end

  describe "self.container_options" do

    it "should always return prototype as model option" do
      klass = Class.new(FreightElementViewModel)
      klass.container_options[:model].should == :prototype
    end

  end

  describe "value=" do

    it "should always call view.update" do
      @view.expects(:update)
      TestElementViewModel = Class.new(FreightElementViewModel)
      view_model = TestElementViewModel.new
      view_model.value = "test"
    end

  end

  describe "value" do

    it "should always return instance variable @value" do
      TestElementViewModel = Class.new(FreightElementViewModel)
      view_model = TestElementViewModel.new
      view_model.instance_variable_set(:@value, "test")
      view_model.value.should == "test"
    end
    
  end

  describe "on_selected" do

    it "should always fire selected with @value" do
      monitor = mock()
      monitor.expects(:called).with("test_value")
      TestElementViewModel = Class.new(FreightElementViewModel)
      view_model = TestElementViewModel.new
      view_model.signals[:selected].connect(lambda { |value| monitor.called(value)})
      view_model.instance_variable_set(:@value, "test_value")
      view_model.on_selected
    end
  end

  describe "control" do

    it "should always return view.control" do
      @view.stubs(:control).returns(1)
      TestElementViewModel = Class.new(FreightElementViewModel)
      view_model = TestElementViewModel.new
      view_model.control.should == 1
    end
  end

  describe "set_selection" do

    it "should always set @selected to param" do
      @view.stubs(:update)
      TestElementViewModel = Class.new(FreightElementViewModel)
      view_model = TestElementViewModel.new
      view_model.set_selection(true)
      view_model.instance_variable_get(:@selected).should == true
    end

    it "should always call view.update" do
      @view.expects(:update)
      TestElementViewModel = Class.new(FreightElementViewModel)
      view_model = TestElementViewModel.new
      view_model.set_selection(true)
    end
    
  end

  
end

