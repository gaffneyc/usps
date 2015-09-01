module USPS
  # Configuration options:
  #   username: Provided by the USPS during registration
  #   timeout: Connection timeout in milliseconds, nil to disable
  #   testing: Should requests be done against the testing service or not
  #            (only specific requests are supported).
  class Configuration < Struct.new(:username, :timeout, :testing, :proxy)
    def initialize
      self.timeout  = 5
      self.testing  = false
      self.username = ENV['USPS_USER']
      self.proxy = nil
    end

    alias :testing? :testing
  end
end
