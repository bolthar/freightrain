
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe DialogHelper do

  describe "open_file_dialog" do

    before :each do
      Gtk::FileChooserDialog.stubs(:new).returns(stub_everything)
      @extender = stub()
      @extender.stubs(:respond_to?).with(:toplevel).returns(true)
      @extender.stubs(:toplevel)
      @extender.class.class_eval("include DialogHelper")
    end

    it "should call Gtk::FileChooserDialog with description provided" do
      param = "test description"
      Gtk::FileChooserDialog.expects(:new).with(
        param,
        anything,
        anything,
        anything,
        anything,
        anything).returns(stub_everything)
      @extender.open_file_dialog(param)
    end

    it "should call Gtk::FileChooserDialog with default description if not provided" do
      Gtk::FileChooserDialog.expects(:new).with(
        "Open file...",
        anything,
        anything,
        anything,
        anything,
        anything).returns(stub(:run => nil, :destroy => nil))
      @extender.open_file_dialog
    end

    it "should return nil if user clicks cancel" do
      Gtk::FileChooserDialog.stubs(:new).returns(
        stub(
          :run => Gtk::Dialog::RESPONSE_CANCEL,
          :destroy => nil))
      @extender.open_file_dialog.should == nil
    end

    it "should return filename if user clicks ok" do
      result = "filename"
      Gtk::FileChooserDialog.stubs(:new).returns(stub(
          :run => Gtk::Dialog::RESPONSE_ACCEPT,
          :filename => result,
          :destroy => nil))
      @extender.open_file_dialog.should == result
    end

    it "should raise if extender does not respond to toplevel" do
      @extender.stubs(:respond_to?).with(:toplevel).returns(false)
      lambda do        
        @extender.open_file_dialog
      end.should raise_error
    end
  end
end

