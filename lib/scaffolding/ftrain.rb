
require File.dirname(__FILE__) + "/generator.rb"

Generator.create_stub("/home/andrea/ftest/views/test_view.rb","view.ftt", :name => 'Test')
Generator.create_stub("/home/andrea/ftest/views/test_view.glade","view_toplevel_glade.ftt", :name => 'Test')
Generator.create_stub("/home/andrea/ftest/views/test_view.bnd.yml","view_bnd.ftt", :name => 'Test')
Generator.create_stub("/home/andrea/ftest/viewmodels/test_view_model.rb","view_model.ftt", :name => 'Test')
Generator.create_stub("/home/andrea/ftest/test.rb","application.ftt", :name => 'test')