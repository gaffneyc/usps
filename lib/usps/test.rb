require 'test/unit'
require 'rubygems'

module USPS
  # This class is a test runner for the various test requests that are outlined
  # in the USPS API documentation. These tests are often used to determine if a
  # developer is allowed to gain access to the production systems.
  #
  # Running this test suite should fullfil all requirements for access to the production
  # system for the APIs supported by the library.
  class Test < Test::Unit::TestCase
    require 'usps/test/zip_code_lookup'
    require 'usps/test/address_verification'
    require 'usps/test/city_and_state_lookup'

    #
    if(ENV['USPS_USER'])
      USPS.username = ENV['USPS_USER']
    else
      raise 'USPS_USER must be set in the environment to run these tests'
    end

    # Set USPS_LIVE to anything to run against production
    USPS.testing = true unless ENV['USPS_LIVE']

    include ZipCodeLookup
    include CityAndStateLookup
    include AddressVerification
  end
end
