require 'spec_helper'

describe USPS::Request::DeliveryConfirmation do
  it 'should be using the proper USPS api settings' do
    USPS::Request::DeliveryConfirmation.tap do |klass|
      expect(klass.secure).to be_truthy
      expect(klass.api).to eq('DeliveryConfirmationV3')
      expect(klass.tag).to eq('DeliveryConfirmationV3.0Request')
    end
  end

  it 'should conform to test request 1' do
    to = USPS::Address.new(
      :name => 'Joe Customer',
      :address => '6060 PRIMACY PKWY',
      :address2 => 'STE 201',
      :city => 'MEMPHIS',
      :state => 'TN'
    )

    from = USPS::Address.new(
      :name => 'John Smith',
      :address => "475 L'Enfant Plaza, SW",
      :city => 'Washington',
      :state => 'DC',
      :zip => 20260
    )

    request = USPS::Request::DeliveryConfirmation.new(to, from, 2).build

    xml = Nokogiri::XML.parse(request)
    expect(xml.search('Option').text).to eq('1')
    expect(xml.search('ImageParameters').text).to eq('')

    expect(xml.search('FromName').text).to eq('John Smith')
    expect(xml.search('FromFirm').text).to eq('')
    expect(xml.search('FromAddress1').text).to eq('')
    expect(xml.search('FromAddress2').text).to eq("475 L'Enfant Plaza, SW")
    expect(xml.search('FromCity').text).to eq('Washington')
    expect(xml.search('FromState').text).to eq('DC')
    expect(xml.search('FromZip5').text).to eq('20260')
    expect(xml.search('FromZip4').text).to eq('')

    expect(xml.search('ToName').text).to eq('Joe Customer')
    expect(xml.search('ToFirm').text).to eq('')
    expect(xml.search('ToAddress1').text).to eq('STE 201')
    expect(xml.search('ToAddress2').text).to eq('6060 PRIMACY PKWY')
    expect(xml.search('ToCity').text).to eq('MEMPHIS')
    expect(xml.search('ToState').text).to eq('TN')
    expect(xml.search('ToZip5').text).to eq('')
    expect(xml.search('ToZip4').text).to eq('')

    expect(xml.search('WeightInOunces').text).to eq('2')
    expect(xml.search('ImageType').text).to eq('TIF')
    expect(xml.search('ServiceType').text).to eq('Priority')
  end
end
