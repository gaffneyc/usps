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

  let(:required_properties) do
    {
      :id                    => "42",
      :service               => "ALL",
      :origin_zip            => "20171",
      :destination_zip       => "08540",
      :pounds                => 5,
      :ounces                => 4,
      :container             => 'VARIABLE',
      :size                  => 'LARGE',
    }
  end

  def package_xml_from_attributes(attributes)
    package = USPS::Package.new(attributes)
    request = USPS::Request::ShippingRatesLookup.new(package)
    Nokogiri::XML.parse(request.build)
  end

  it "builds a valid XML request for USPS RateV4" do
    package_properties = required_properties.merge(
      :first_class_mail_type => 'PARCEL',
      :height                => 13,
      :width                 => 10,
      :length                => 15
    )
    package_xml = package_xml_from_attributes(package_properties)

    package_xml.search('Package').count.should == 1
    first_package = package_xml.search('Package').first
    first_package.attr('ID').should                        == "42"
    first_package.search('Service').text.should            == 'ALL'
    first_package.search('FirstClassMailType').text.should == 'PARCEL'
    first_package.search('ZipOrigination').text.should     == '20171'
    first_package.search('ZipDestination').text.should     == '08540'
    first_package.search('Pounds').text.should             == '5'
    first_package.search('Ounces').text.should             == '4'
    first_package.search('Container').text.should          == 'VARIABLE'
    first_package.search('Size').text.should               == 'LARGE'
    first_package.search('Height').text.should             == '13'
    first_package.search('Width').text.should              == '10'
    first_package.search('Length').text.should             == '15'
  end

  it "doesn't serialize dimension properties when package size is REGULAR" do
    package_xml   = package_xml_from_attributes(required_properties.merge :size => 'REGULAR')
    first_package = package_xml.search('Package').first

    %w{Height Width Length}.each do |dimension|
      first_package.search(dimension).should be_empty
    end
  end
end
