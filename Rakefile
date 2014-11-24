require 'bundler/setup'
Bundler::GemHelper.install_tasks

require 'rake'

desc "Run the certification tests against USPS's API. Requires ENV['USPS_USER'] to be set or passed in."
task :certify do
  ruby "-rubygems -Ilib lib/usps/test.rb"
end
