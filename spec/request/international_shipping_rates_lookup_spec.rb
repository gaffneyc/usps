require 'spec_helper'

module USPS::Request
  describe InternationalShippingRatesLookup do
    it "uses the IntlRateV2 API settings" do
      InternationalShippingRatesLookup.tap do |klass|
        klass.secure.should be_false
        klass.api.should == 'IntlRateV2'
        klass.tag.should == 'IntlRateV2Request'
      end
    end

    it "requires at least one package" do
      expect {
        request = InternationalShippingRatesLookup.new
      }.to raise_exception(ArgumentError)
    end

    let(:required_properties) do
      {
        :id        => "42",
        :country   => "Japan",
        :mail_type => "LargeEnvelope",
        :pounds    => 3,
        :ounces    => 5,
        :container => 'RECTANGULAR',
        :size      => 'LARGE',
      }
    end

    def package_xml_from_attributes(attributes)
      package = Package::InternationalPackage.new(attributes)
      request = InternationalShippingRatesLookup.new(package)
      Nokogiri::XML.parse(request.build)
    end

    it "builds a valid XML request for USPS IntlRateV2" do
      package_properties = required_properties.merge(
        :height                => 13,
        :width                 => 10,
        :length                => 15
      )
      package_xml = package_xml_from_attributes(package_properties)

      package_xml.search('Package').count.should == 1
      first_package = package_xml.search('Package').first
      first_package.attr('ID').should                        == "42"
      first_package.search('Pounds').text.should             == '3'
      first_package.search('Ounces').text.should             == '5'
      first_package.search('Container').text.should          == 'RECTANGULAR'
      first_package.search('Size').text.should               == 'LARGE'
      first_package.search('Height').text.should             == '13'
      first_package.search('Width').text.should              == '10'
      first_package.search('Length').text.should             == '15'
    end
  end
end
