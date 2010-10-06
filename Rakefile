
require 'rubygems'
require 'spec/rake/spectask'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'

spec = Gem::Specification.new do |s|
  s.name = 'freightrain'
  s.version = '0.6.9'
  s.add_dependency('require_all', '>= 1.1.0')
  s.add_dependency('needle', '>= 1.3.0')
  s.has_rdoc = false
  s.homepage = "http://github.com/bolthar/freightrain"
  s.executables = ['ftrain']
  s.summary = 'ruby desktop development made easy'
  s.description = s.summary
  s.author = 'Andrea Dallera'
  s.email = 'andrea@andreadallera.com'
  s.files = %w(README.rdoc Rakefile) + Dir.glob("{bin,lib}/**/*")
  s.require_path = "lib"  
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Spec::Rake::SpecTask.new do |t|
  t.warning = true
  t.spec_files = FileList['spec/**/*.rb']
end
