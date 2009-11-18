
require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Gtk::Image do

  before :each do
    FreightBinding.stubs(:new)
  end

  describe "bind" do

    it "should set converter to PixbufConverter on options if property is pixbuf" do
      options = {:property => :pixbuf}
      image = Gtk::Image.new
      image.bind(options)
      options[:converter].should be_a_kind_of(PixbufConverter)
    end
    
  end
  
end

