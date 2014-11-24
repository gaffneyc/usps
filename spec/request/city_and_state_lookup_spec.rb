require 'spec_helper'

describe USPS::Request::CityAndStateLookup do
  it "should be using the proper USPS api settings" do
    USPS::Request::CityAndStateLookup.tap do |klass|
      expect(klass.secure).to be_falsey
      expect(klass.api).to eq('CityStateLookup')
      expect(klass.tag).to eq('CityStateLookupRequest')
    end
  end

  it "should not allow more than 5 addresses" do
    expect do
      USPS::Request::CityAndStateLookup.new([12345] * 10)
    end.to raise_exception(ArgumentError)
  end

  it "should be able to build a proper request" do
    request = USPS::Request::CityAndStateLookup.new(
      90210, 48917, 49423, 99111, 12345
    )

    xml = Nokogiri::XML.parse(request.build)

    #
    expect(xml.search('ZipCode[@ID="0"]/Zip5').text).to eq('90210')
    expect(xml.search('ZipCode[@ID="1"]/Zip5').text).to eq('48917')
    expect(xml.search('ZipCode[@ID="2"]/Zip5').text).to eq('49423')
    expect(xml.search('ZipCode[@ID="3"]/Zip5').text).to eq('99111')
    expect(xml.search('ZipCode[@ID="4"]/Zip5').text).to eq('12345')
  end
end
