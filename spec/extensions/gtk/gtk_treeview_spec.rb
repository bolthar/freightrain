#
#require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')
#
#describe Gtk::TreeView do
#
#  before :each do
#    FreightBinding.stubs(:new)
#  end
#
#  describe "bind" do
#
#    it "should set treeview to ListStoreConverter on options if property is pixbuf" do
#      options = {:property => :model}
#      treeview = Gtk::TreeView.new
#      treeview.bind(options)
#      options[:treeview].should be_a_kind_of(ListStoreConverter)
#    end
#
#    it "should call ListStoreConverter ctor with treeview columns" do
#      options = {:property => :model}
#      treeview = Gtk::TreeView.new
#      treeview.append_column Gtk::TreeViewColumn.new("dummy")
#      ListStoreConverter.expects(:new).with(treeview.columns)
#      treeview.bind(options)
#    end
#
#  before :each do
#      @column_one = stub()
#      @column_one.stubs(:type).returns(String)
#      @column_one.stubs(:path).returns(:path_one)
#      @column_one.stubs(:cell_renderers).returns([stub_everything])
#      @column_one.stubs(:property).returns(:dummy)
#      @column_one.stubs(:set_attributes)
#      @column_two = stub()
#      @column_two.stubs(:type).returns(Fixnum)
#      @column_two.stubs(:path).returns(:path_two)
#      @column_two.stubs(:cell_renderers).returns([stub_everything])
#      @column_two.stubs(:property).returns(:dummy)
#      @column_two.stubs(:set_attributes)
#      @treeview = Gtk::TreeView.new
#      @treeview.stubs(:columns).returns([@column_one, @column_two])
#  end
#
#  it "should call set_attributes on each column with right parameters" do
#    @column_one.stubs(:property).returns(:property_one)
#    @column_one.expects(:set_attributes).with(anything, {:property_one => 1})
#    ListStoreConverter.new([@column_one])
#  end
#
#  describe "elements = " do
#
#    it "should call ListStore.new with an array of object + column types" do
#      Gtk::ListStore.expects(:new).with(Object, String, Fixnum)
#      @treeview.elements = []
#    end
#
#    it "should assign each element of enumerable to iterator[0]" do
#      iterator = mock()
#      iterator.expects(:[]=).with(0, :testitem)
#      list_store = stub
#      list_store.stubs(:append).returns(iterator)
#      Gtk::ListStore.stubs(:new).returns(list_store)
#      treeview = Gtk::TreeView.new
#      treeview.from([:testitem])
#    end
#
#    it "should set iterator correct indexes to path values" do
#      iterator = mock()
#      iterator.stubs(:[]=).with(0, anything)
#      iterator.expects(:[]=).with(1, :value_one)
#      iterator.expects(:[]=).with(2, :value_two)
#      item = stub()
#      item.stubs(:path_one).returns(:value_one)
#      item.stubs(:path_two).returns(:value_two)
#      list_store = stub
#      list_store.stubs(:append).returns(iterator)
#      Gtk::ListStore.stubs(:new).returns(list_store)
#      treeview = ListStoreConverter.new([@column_one, @column_two])
#      treeview.from([item])
#    end
#
#   end
#
#  end
#
#end
#
