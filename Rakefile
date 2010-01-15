require 'rubygems'
require 'rake'

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name = "usps"
    gem.summary = "USPS Webtools API for Ruby"
    gem.description = "USPS Webtools API for Ruby."
    gem.email = "gaffneyc@gmail.com"
    gem.homepage = "http://github.com/gaffneyc/usps"
    gem.authors = ["Chris Gaffney"]

    gem.add_dependency 'builder',  '>= 2.1.2'
    gem.add_dependency 'nokogiri', '>= 1.4.1'

    gem.add_development_dependency "mocha", ">= 0.9.8"
    gem.add_development_dependency "rspec", ">= 1.3.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "usps #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
