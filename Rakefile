
require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'spec/rake/spectask'

spec = Gem::Specification.new do |s|
  s.name = 'freightrain'
  s.version = '0.0.4'
  s.has_rdoc = false
  s.summary = 'ruby desktop development made easy'
  s.description = s.summary
  s.author = 'Andrea Dallera'
  s.email = 'andrea@andreadallera.com'
  s.files = %w(README Rakefile) + Dir.glob("{bin,lib}/**/*")
  s.require_path = "lib"
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end
