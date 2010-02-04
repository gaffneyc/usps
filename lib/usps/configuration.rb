module USPS
  class Configuration < Struct.new(:username, :timeout, :testing)
    def initialize
      self.timeout  = 5
      self.testing  = false
      self.username = ENV['USPS_USER']
    end
  end
end
