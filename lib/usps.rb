require 'builder'
require 'nokogiri'

module USPS
  require 'usps/errors'
  require 'usps/configuration'

  autoload :Client,          'usps/client'
  autoload :Address,         'usps/address'
  autoload :Request,         'usps/request'
  autoload :VERSION,         'usps/version'
  autoload :Response,        'usps/response'
  autoload :TrackDetail,     'usps/track_detail'

  class << self
    attr_writer :config

    def client
      @client ||= Client.new
    end

    def testing=(val)
      config.testing = val
    end

    def config
      @config ||= Configuration.new
    end

    def configure(&block)
      block.call(self.config)
    end

    # These two methods are currently here for backwards compatability
    def username=(user)
      config.username = user
    end

    def username
      config.username
    end

    def get_city_and_state_for_zip(zip)
      USPS::Request::CityAndStateLookup.new(zip).send!.get(zip)
    end
  end
end
