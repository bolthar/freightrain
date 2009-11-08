
require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Gtk::TreeViewColumn do

  before :each do
    @column = Gtk::TreeViewColumn.new("dummy")
  end

  it "should have an accessor for path" do
    @column.path = "mypath"
    @column.path.should == "mypath"
  end

  it "should return String if type is not set" do
    @column.type.should == String
  end

  it "should return setted type if setter called" do
    @column.type = Fixnum
    @column.type.should == Fixnum
  end

  it "should return :text if property is not set" do
    @column.property.should == :text
  end

  it "should return setted property if setter called" do
    @column.property = :width
    @column.property.should == :width
  end
end

