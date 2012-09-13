module USPS::Request

  class InternationalShippingRatesLookup < Base
    config(
      :api => 'IntlRateV2',
      :tag => 'IntlRateV2Request',
      :secure => false,
      :response => USPS::Response::InternationalShippingRatesLookup
    )

    def initialize(*packages)
      @packages = packages.flatten
      if @packages.none?
        raise ArgumentError, 'A shipping rate lookup requires at least one package (USPS::Package)'
      end
    end

    def build
      super do |xml|
        xml.Revision 2
        @packages.each do |package|
          xml.Package :ID => package.id do
            xml.Pounds package.pounds
            xml.Ounces package.ounces
            xml.Machinable 'true' # for Service=ALL
            xml.MailType package.mail_type
            xml.ValueOfContents 103
            xml.Country package.country
            xml.Container package.container
            xml.Size package.size
            xml.Width package.width
            xml.Length package.length
            xml.Height package.height
            xml.Girth nil
            xml.CommercialFlag 'N'
          end
        end
      end
    end

  end
end
