require 'spec_helper'

describe USPS::Request::DeliveryConfirmation do
  it 'should be using the proper USPS api settings' do
    USPS::Request::DeliveryConfirmation.tap do |klass|
      klass.secure.should be_true
      klass.api.should == 'DeliveryConfirmationV3'
      klass.tag.should == 'DeliveryConfirmationV3.0Request'
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
    xml.search('Option').text.should == '1'
    xml.search('ImageParameters').text.should == ''

    xml.search('FromName').text.should == 'John Smith'
    xml.search('FromFirm').text.should == ''
    xml.search('FromAddress1').text.should == ''
    xml.search('FromAddress2').text.should == "475 L'Enfant Plaza, SW"
    xml.search('FromCity').text.should == 'Washington'
    xml.search('FromState').text.should == 'DC'
    xml.search('FromZip5').text.should == '20260'
    xml.search('FromZip4').text.should == ''

    xml.search('ToName').text.should == 'Joe Customer'
    xml.search('ToFirm').text.should == ''
    xml.search('ToAddress1').text.should == 'STE 201'
    xml.search('ToAddress2').text.should == '6060 PRIMACY PKWY'
    xml.search('ToCity').text.should == 'MEMPHIS'
    xml.search('ToState').text.should == 'TN'
    xml.search('ToZip5').text.should == ''
    xml.search('ToZip4').text.should == ''

    xml.search('WeightInOunces').text.should == '2'
    xml.search('ImageType').text.should == 'TIF'
    xml.search('ServiceType').text.should == 'Priority'
  end
end
