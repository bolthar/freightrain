# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'freightrain/dialog_helper.rb'
require 'mocha'
require 'libglade2'

include Freightrain

class TestDHF
  include DialogHelper
  

end

class DialogHelperFixture < Test::Unit::TestCase

  def test_openfiledialog_callWithNoArguments_createDialogwithDefaultdescription
    dialog_mock = mock()
    dialog_mock.stubs(:run)
    dialog_mock.stubs(:destroy)
    Gtk::FileChooserDialog.expects(:new).with(
      "Open file...",
      anything,
      anything,
      anything,
      anything,
      anything).returns(dialog_mock)
    test = TestDHF.new
    test.stubs(:toplevel)
    test.open_file_dialog
  end
  
  def test_openfiledialog_callWithArgument_createDialogwithArgument
    argument = "my description"
    dialog_mock = mock()
    dialog_mock.stubs(:run)
    dialog_mock.stubs(:destroy)
    Gtk::FileChooserDialog.expects(:new).with(
      "my description",
      anything,
      anything,
      anything,
      anything,
      anything).returns(dialog_mock)
    test = TestDHF.new
    test.stubs(:toplevel)
    test.open_file_dialog(argument)
  end

  def test_openfiledialog_openNotPressed_returnNil
    dialog_mock = mock()
    dialog_mock.stubs(:run)
    dialog_mock.stubs(:destroy)
    Gtk::FileChooserDialog.expects(:new).returns(dialog_mock)
    test = TestDHF.new
    test.stubs(:toplevel)
    assert_equal nil, test.open_file_dialog
  end

  def test_openfiledialog_openPressed_returnFilename
    result = "testfilename"
    dialog_mock = mock()
    dialog_mock.stubs(:run).returns(Gtk::Dialog::RESPONSE_ACCEPT)
    dialog_mock.stubs(:filename).returns(result)
    dialog_mock.stubs(:destroy)
    Gtk::FileChooserDialog.expects(:new).returns(dialog_mock)
    test = TestDHF.new
    test.stubs(:toplevel)
    assert_equal result, test.open_file_dialog
  end
  
end
