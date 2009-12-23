
require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')


describe DialogHelper do

  describe "open file dialog" do

    before :each do
      Gtk::FileChooserDialog.stubs(:new).returns(stub_everything)
      @extender = stub()
      @extender.stubs(:respond_to?).with(:toplevel).returns(true)
      @extender.stubs(:toplevel)
      @extender.class.class_eval("include DialogHelper")
    end

    it "should raise if extender does not respond to toplevel" do
      @extender.stubs(:respond_to?).with(:toplevel).returns(false)
      lambda do
        @extender.open_file_dialog
      end.should raise_error
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
  
  end


  describe "yes/no dialog" do

    before :each do
      Gtk::MessageDialog.stubs(:new).returns(stub_everything)
      @extender = stub()
      @extender.stubs(:respond_to?).with(:toplevel).returns(true)
      @extender.stubs(:toplevel)
      @extender.class.class_eval("include DialogHelper")
    end

    it "should raise if extender does not respond to toplevel" do
      @extender.stubs(:respond_to?).with(:toplevel).returns(false)
      lambda do
        @extender.yes_no_dialog
      end.should raise_error
    end

    it "should call Gtk::MessageDialog with description provided" do
      param = "test description"
      Gtk::MessageDialog.expects(:new).with(
        anything,
        anything,
        anything,
        anything,
        param).returns(stub_everything)
      @extender.yes_no_dialog(param)
    end

    it "should call title on dialog if title provided" do
      test_title = "my title"
      dialog = stub_everything()
      Gtk::MessageDialog.stubs(:new).with(
        anything,
        anything,
        anything,
        anything,
        anything).returns(dialog)
      dialog.expects(:title=).with(test_title)
      @extender.yes_no_dialog("dummy", test_title)
    end

    it "should call title on dialog with 'Warning!' if title not provided" do
      dialog = stub_everything()
      Gtk::MessageDialog.stubs(:new).with(
        anything,
        anything,
        anything,
        anything,
        anything).returns(dialog)
      dialog.expects(:title=).with("Warning!")
      @extender.yes_no_dialog("dummy")
    end

    it "should call secondary_text on dialog if secondary text provided" do
      test_secondary_text = "my secondary text"
      dialog = stub_everything()
      Gtk::MessageDialog.stubs(:new).with(
        anything,
        anything,
        anything,
        anything,
        anything).returns(dialog)
      dialog.expects(:secondary_text=).with(test_secondary_text)
      @extender.yes_no_dialog("dummy", "dummy", test_secondary_text)
    end

    it "should call secondary_text on dialog with correct text if secondary text not provided" do
      dialog = stub_everything()
      Gtk::MessageDialog.stubs(:new).with(
        anything,
        anything,
        anything,
        anything,
        anything).returns(dialog)
      dialog.expects(:secondary_text=).with("It will not be possible to recover the deleted item")
      @extender.yes_no_dialog("dummy")
    end

    it "should return false if user does not click yes" do
      dialog = stub_everything()
      dialog.stubs(:run).yields(Gtk::Dialog::RESPONSE_NO)
      dialog.stubs(:destroy)
      Gtk::MessageDialog.stubs(:new).returns(dialog)
      @extender.yes_no_dialog("dummy").should == false
    end
    it "should return true if user clicks yes" do
      dialog = stub_everything()
      dialog.stubs(:run).yields(Gtk::Dialog::RESPONSE_YES)
      dialog.stubs(:destroy)
      Gtk::MessageDialog.stubs(:new).returns(dialog)
      @extender.yes_no_dialog("dummy").should == true
    end

  end
end

