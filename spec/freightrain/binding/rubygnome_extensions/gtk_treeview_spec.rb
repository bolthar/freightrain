
require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Gtk::TreeView do

  before :each do
    FreightBinding.stubs(:new)
  end

  describe "bind" do

    it "should set converter to ListStoreConverter on options if property is pixbuf" do
      options = {:property => :model}
      treeview = Gtk::TreeView.new
      treeview.bind(options)
      options[:converter].should be_a_kind_of(ListStoreConverter)
    end

    it "should call ListStoreConverter ctor with treeview columns" do
      options = {:property => :model}
      treeview = Gtk::TreeView.new
      treeview.append_column Gtk::TreeViewColumn.new("dummy")
      ListStoreConverter.expects(:new).with(treeview.columns)
      treeview.bind(options)
    end
    
  end
  
end

