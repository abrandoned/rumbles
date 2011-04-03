require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'

jeweler_tasks = Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "rumbles"
  gem.homepage = "http://github.com/bdewitt/rumbles"
  gem.license = "MIT"
  gem.summary = %Q{ one-line summary of your gem}
  gem.description = %Q{ longer description of your gem}
  gem.email = "brandon+rumbles@myjibe.com"
  gem.authors = ["Brandon Dewitt"]
  gem.extensions = FileList['ext/**/extconf.rb']
  gem.version = File.read('VERSION')
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  gem.add_runtime_dependency 'ffi'
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
end
Jeweler::RubygemsDotOrgTasks.new
$gemspec = jeweler_tasks.gemspec

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rumbles #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

$gemspec.version = jeweler_tasks.jeweler.version

require 'rake/extensiontask'

Rake::ExtensionTask.new do |ext|
  ext.name = "libmurmur1"
  ext.ext_dir = "ext/libmurmur1"
  ext.lib_dir = "lib/rumbles/ffi_murmur/lib"
  ext.tmp_dir = "tmp"
  ext.gem_spec = $gemspec
end

Rake::ExtensionTask.new do |ext|
  ext.name = "libmurmur2"
  ext.ext_dir = "ext/libmurmur2"
  ext.lib_dir = "lib/rumbles/ffi_murmur/lib"
  ext.tmp_dir = "tmp"
  ext.gem_spec = $gemspec
end

Rake::ExtensionTask.new do |ext|
  ext.name = "libmurmur3"
  ext.ext_dir = "ext/libmurmur3"
  ext.lib_dir = "lib/rumbles/ffi_murmur/lib"
  ext.tmp_dir = "tmp"
  ext.gem_spec = $gemspec
end

