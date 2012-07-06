require 'spec_helper'

describe USPS::Request::ShippingRatesLookup do
  it "uses the RateV4 API settings" do
    USPS::Request::ShippingRatesLookup.tap do |klass|
      klass.secure.should be_false
      klass.api.should == 'RateV4'
      klass.tag.should == 'RateV4Request'
    end
  end

  it "requires at least one package" do
    expect {
      request = USPS::Request::ShippingRatesLookup.new
    }.to raise_exception(ArgumentError)
  end

  it "builds a valid XML request for USPS RateV4" do
    package = USPS::Package.new do |new_package|
      new_package.id              = "42"
      new_package.service         = "ALL"
      new_package.origin_zip      = "20171"
      new_package.destination_zip = "08540"
      new_package.pounds          = 5
      new_package.ounces          = 4
      new_package.container       = 'VARIABLE'
      new_package.size            = 'LARGE'
    end

    request = USPS::Request::ShippingRatesLookup.new(package).build
    xml = Nokogiri::XML.parse(request)

    xml.search('Package').count.should == 1

    first_package = xml.search('Package').first
    first_package.attr('ID').should                    == "42"
    first_package.search('Service').text.should        == 'ALL'
    first_package.search('ZipOrigination').text.should == '20171'
    first_package.search('ZipDestination').text.should == '08540'
    first_package.search('Pounds').text.should         == '5'
    first_package.search('Ounces').text.should         == '4'
    first_package.search('Container').text.should      == 'VARIABLE'
    first_package.search('Size').text.should           == 'LARGE'
  end
end
