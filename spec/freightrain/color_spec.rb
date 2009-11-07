
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Color do

  describe "self.rgb" do

    it "should raise if called with uncorrect parameter" do
      lambda do
        Color.rgb(nil)
      end.should raise_error
    end


    it "should create a gdk::color according to param.to_s" do
      test_color = "#FF00A4"
      Gdk::Color.expects(:new).with(65535,255,42239)
      Color.rgb(test_color)
    end

  end


end

