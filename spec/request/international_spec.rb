require 'spec_helper'

module USPS::Request
  describe InternationalShippingRatesLookup do
    USPS.username = '414REENH3307'
    it "uses the RateV4 API settings" do
      package = Package::InternationalPackage.new(
        :country => "Canada", :id => 3, :mail_type => 'Package', :pounds => 20, :ounces => 5, :container => 'RECTANGULAR', :size => 'LARGE',
        :width => 10, :height => 12, :length => 13
      )
      lookup = InternationalShippingRatesLookup.new(package)
      response = lookup.send!
      response.packages.each do |package|
        package.services.each do |service|
          puts "#{service.rate} - #{service.description}"
        end
      end
    end
  end
end
