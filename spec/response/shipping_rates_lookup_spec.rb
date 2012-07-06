require 'spec_helper'

describe USPS::Response::ShippingRatesLookup do

  it "correctly parses a USPS RateV4 XML response" do
    response = USPS::Response::ShippingRatesLookup.new(load_xml("shipping_rates_lookup.xml"))
    response.should have(1).packages
    response.packages.first.tap do |package|
      package.should have(5).postages
      package.id.should              == '42'
      package.origin_zip.should      == '20171'
      package.destination_zip.should == '08540'
      package.pounds.should          == '2'
      package.ounces.should          == '0'
      package.size.should            == 'REGULAR'
    end
  end
end
