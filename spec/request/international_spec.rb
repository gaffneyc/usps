require 'spec_helper'

module USPS::Request
  describe InternationalShippingRatesLookup do
    USPS.username = '414REENH3307'
    it "uses the RateV4 API settings" do
      package = Package::InternationalPackage.new(
        :country => "Romania", :id => 3, :mail_type => 'ALL', :pounds => 7, :ounces => 0, :container => 'RECTANGULAR', :size => 'LARGE',
        :width => 12, :height => 13, :length => 12
      )
      lookup = InternationalShippingRatesLookup.new(package)
      response = lookup.send!
      response.packages.each do |package|
        package.services.each do |service|
          puts "#{service.id} - #{service.rate} - #{service.description}"
        end
      end
    end
  end
end
