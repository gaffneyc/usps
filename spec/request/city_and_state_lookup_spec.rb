require 'spec_helper'

describe USPS::Request::CityAndStateLookup do
  it "should be using the proper USPS api settings" do
    USPS::Request::CityAndStateLookup.tap do |klass|
      klass.secure.should be_false
      klass.api.should == 'CityStateLookup'
      klass.tag.should == 'CityStateLookupRequest'
    end
  end

  it "should not allow more than 5 addresses" do
    Proc.new do
      USPS::Request::CityAndStateLookup.new([12345] * 10)
    end.should raise_exception(ArgumentError)
  end

  it "should be able to build a proper request" do
    request = USPS::Request::CityAndStateLookup.new(
      90210, 48917, 49423, 99111, 12345
    )

    xml = Nokogiri::XML.parse(request.build)

    #
    xml.search('ZipCode[@ID="0"]/Zip5').text.should == '90210'
    xml.search('ZipCode[@ID="1"]/Zip5').text.should == '48917'
    xml.search('ZipCode[@ID="2"]/Zip5').text.should == '49423'
    xml.search('ZipCode[@ID="3"]/Zip5').text.should == '99111'
    xml.search('ZipCode[@ID="4"]/Zip5').text.should == '12345'
  end
end
