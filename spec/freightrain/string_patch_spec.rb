
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe String do
  
  describe "to convention sym" do 
    
    it "should return nil if string is empty" do 
      "".to_convention_sym.should == nil
    end
    
    it "should return string as symbol if no uppercase letters" do 
      "nouppercase".to_convention_sym.should == :nouppercase
    end
    
    it "should return symbol with first letter lowercase if first letter is uppercase" do
      "Firstuppercase".to_convention_sym.should == :firstuppercase
    end
    
    it "should return symbol with letter downcase and underscore if uppercase letter in between" do
      "inBetween".to_convention_sym.should == :in_between
    end
    
    
  end

end

