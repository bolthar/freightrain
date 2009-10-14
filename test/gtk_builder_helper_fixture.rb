# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'freightrain/gtk_builder_helper.rb'
require 'mocha'

include Freightrain

class TestView
  include GtkBuilderHelper

end

class GtkBuilderHelperFixture < Test::Unit::TestCase

  def test_loadFromFile_fileNotFound_DoNotThrow
    view = TestView.new
    view.load_from_file("nofile")
  end

  def test_loadFromFile_gtkbuilderfilepresent_addaClassMethodForeachWidget
    view = TestView.new
    view.load_from_file(File.dirname(__FILE__) + "/testview.glade")
    assert(view.respond_to? :window)
  end


  
end
