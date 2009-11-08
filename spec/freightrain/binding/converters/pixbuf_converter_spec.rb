
require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe PixbufConverter do

  describe "from" do

    before :each do
      @file = stub()
      @file.stubs(:<<)
      @file.stubs(:close)
      Gdk::Pixbuf.stubs(:new)
      Dir.stubs(:tmpdir).returns(:testdir)
      File.stubs(:join).returns(:right_filename)
      File.stubs(:new).returns(@file)
    end

    it "should create new file with right params" do     
      File.expects(:new).with(:right_filename, 'w').returns(@file)
      PixbufConverter.new(:id).from(nil)
    end

    it "should call File.join with Dir.tmpdir value and dummy string + id + .jpg" do
      File.expects(:join).with(:testdir, "tempimg_myid_.jpg")
      PixbufConverter.new("_myid_").from(nil)
    end

    it "should call << on file with passed value" do
      @file.expects(:<<).with(:test_value)
      PixbufConverter.new(:id).from(:test_value)
    end

    it "should close file" do
      @file.expects(:close)
      PixbufConverter.new(:id).from(:test_value)
    end

    it "should call Gdk::Pixbuf.new with right path" do
      Gdk::Pixbuf.expects(:new).with(:right_filename)
      PixbufConverter.new(:id).from(nil)
    end
  end
end

