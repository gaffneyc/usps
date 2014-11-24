require 'spec_helper'

describe USPS::Request::AddressStandardization do
  it "should be using the proper USPS api settings" do
    USPS::Request::AddressStandardization.tap do |klass|
      expect(klass.secure).to be_falsey
      expect(klass.api).to eq('Verify')
      expect(klass.tag).to eq('AddressValidateRequest')
    end
  end

  it "should not allow more than 5 addresses" do
    expect do
      USPS::Request::AddressStandardization.new([USPS::Address.new] * 6)
    end.to raise_exception(ArgumentError)
  end
    
  it "should be able to build a proper request" do
    request = USPS::Request::AddressStandardization.new(
      USPS::Address.new(
        :name => 'Joe Jackson',
        :company => 'Widget Tel Co.',
        :address => '999 Serious Business Av',
        :address2 => 'Suite 2000',
        :city  => 'Awesome Town',
        :state => 'FL',
        :zip => '12345-9900'
      )
    )

    xml = Nokogiri::XML.parse(request.build)

    xml.search('Address').first.tap do |node|
      expect(node.attr('ID')).to eq('0')

      expect(node.search('FirmName').text).to eq('Widget Tel Co.')
      expect(node.search('Address1').text).to eq('Suite 2000')
      expect(node.search('Address2').text).to eq('999 Serious Business Av')
      expect(node.search('City').text).to eq('Awesome Town')
      expect(node.search('State').text).to eq('FL')
      expect(node.search('Zip5').text).to eq('12345')
      expect(node.search('Zip4').text).to eq('9900')
    end
  end
end
