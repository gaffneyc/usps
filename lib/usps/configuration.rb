module USPS
  # Configuration options:
  #   username: Provided by the USPS during registration
  #   timeout: How many seconds to wait for a response before raising Timeout::Error
  #   testing: Should requests be done against the testing service or not
  #            (only specific requests are supported).
  class Configuration < Struct.new(:username, :timeout, :testing)
    def initialize
      self.timeout  = 5
      self.testing  = false
      self.username = ENV['USPS_USER']
    end

    alias :testing? :testing
  end
end
