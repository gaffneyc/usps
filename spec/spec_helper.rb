$:.unshift(File.dirname(__FILE__))
$:.unshift(File.join(File.dirname(__FILE__), %w(.. lib)))

require 'rubygems'

require 'usps'
require 'spec'
require 'spec/autorun'

require 'builder'
require 'nokogiri'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

USPS.username = 'TESTING'

def load_data(path)
  (@_file_cache ||= {})[path] ||= File.read(File.expand_path(File.join(File.dirname(__FILE__), 'data', path)))
end

def load_xml(path)
  Nokogiri::XML.parse(load_data(path))
end
