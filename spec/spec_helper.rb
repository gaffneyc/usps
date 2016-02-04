require 'bundler/setup'
Bundler.require(:default, :development)

require 'usps'
USPS.username = 'TESTING'

require 'webmock/rspec'

def load_data(path)
  (@_file_cache ||= {})[path] ||= File.read(File.expand_path("../data/#{path}", __FILE__))
end

def load_xml(path)
  Nokogiri::XML.parse(load_data(path))
end
