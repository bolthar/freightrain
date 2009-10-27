
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require File.dirname(__FILE__) + '/../../lib/freightrain/container_hookable.rb'

include Freightrain

describe ContainerHookable do

  describe "subclasses" do

    it "should return an empty array if never extended" do
      ContainerHookable.classes.length.should == 0
    end

    it "should return an array with extending classes" do
      Class.new().class_eval("extend ContainerHookable")
      Class.new().class_eval("extend ContainerHookable")
      ContainerHookable.classes.length.should == 2
    end

    it "should return an empty array if extending class is never inherited" do
      klass = Class.new().class_eval("extend ContainerHookable")
      klass.subclasses.length.should == 0
    end

    it "should return an array with of classes inheriting the extended class" do
      base_class = Class.new().class_eval("extend ContainerHookable")
      Class.new(base_class)
      Class.new(base_class)
      base_class.subclasses.length.should == 2
    end



  end
  
end

