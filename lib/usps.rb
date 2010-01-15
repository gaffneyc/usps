require 'builder'
require 'nokogiri'

module USPS
  require 'usps/errors'

  autoload :Client,   'usps/client'
  autoload :Address,  'usps/address'
  autoload :Request,  'usps/request'
  autoload :Response, 'usps/response'

  class << self
    attr_accessor :username

    def client
      @client ||= Client.new
    end

    def testing=(val)
      self.client.testing = true
    end

    def get_city_and_state_for_zip(zip)
      USPS::Request::CityAndStateLookup.new(zip).send!.get(zip)
    end
  end

end
