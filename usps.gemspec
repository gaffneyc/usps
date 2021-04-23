# encoding: UTF-8
require File.expand_path('../lib/usps/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = "usps"
  s.homepage     = "http://github.com/gaffneyc/usps"
  s.summary      = "USPS Webtools API for Ruby"
  s.require_path = "lib"
  s.authors      = ["Chris Gaffney"]
  s.email        = ["gaffneyc@gmail.com"]
  s.version      = USPS::VERSION
  s.platform     = Gem::Platform::RUBY
  s.files        = Dir.glob("{lib,spec}/**/*") + %w(Rakefile LICENSE README.md)

  s.add_runtime_dependency("builder",  ">= 2.1.2")
  s.add_runtime_dependency("nokogiri", ">= 1.4.1")
  s.add_runtime_dependency("typhoeus", ">= 0.1.18")
  s.add_development_dependency("test-unit", ">= 3.0.0")
end

