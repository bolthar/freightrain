
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'freightrain.rb'
require 'rubygems'
require 'mocha'

include Freightrain

class AutoRequirerFixture < Test::Unit::TestCase

  def test_onFTStart_always_callAutoRequire
    Gtk.stubs(:main)
    Freightrain.expects(:auto_require!)
    Freightrain.start(stub(:new => stub(:show)))
  end
  
  def test_autorequire_always_loadAllFirstLevelViews    
    Freightrain.stubs(:require)
    Freightrain.expects(:require).with(File.join(File.dirname(__FILE__),"views","view_1.rb"))
    Freightrain.APP_PATH = File.dirname(__FILE__)
    Freightrain.auto_require!
  end

  def test_autorequire_always_loadAllFirstLevelViewmodels
    Freightrain.stubs(:require)
    Freightrain.expects(:require).with(File.join(File.dirname(__FILE__),"viewmodels","viewmodel_1.rb"))
    Freightrain.APP_PATH = File.dirname(__FILE__)
    Freightrain.auto_require!
  end

  def test_autorequire_always_loadAllFirstLevelServices
    Freightrain.stubs(:require)
    Freightrain.expects(:require).with(File.join(File.dirname(__FILE__),"services","service_1.rb"))
    Freightrain.APP_PATH = File.dirname(__FILE__)
    Freightrain.auto_require!
  end

  def test_autorequire_always_loadAllFirstLevelModels
    Freightrain.stubs(:require)
    Freightrain.expects(:require).with(File.join(File.dirname(__FILE__),"domain","model_1.rb"))
    Freightrain.APP_PATH = File.dirname(__FILE__)
    Freightrain.auto_require!
  end



end