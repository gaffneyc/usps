module USPS::Request

  class ShippingRatesLookup < Base
    config(
      :api => 'RateV4',
      :tag => 'RateV4Request',
      :secure => false,
      :response => USPS::Response::ShippingRatesLookup
    )

    def initialize(*packages)
      @packages = packages.flatten
      if @packages.none?
        raise ArgumentError, 'A shipping rate lookup requires at least one package (USPS::Package)'
      end
    end

    def build
      super do |xml|
        @packages.each do |package|
          xml.Package :ID => package.id do
            xml.Service package.service
            xml.FirstClassMailType(package.first_class_mail_type) if package.first_class_mail_type
            xml.ZipOrigination package.origin_zip
            xml.ZipDestination package.destination_zip
            xml.Pounds package.pounds
            xml.Ounces package.ounces
            xml.Container package.container
            xml.Size package.size
            if package.size == 'LARGE'
              xml.Width package.width
              xml.Length package.length
              xml.Height package.height
            end
            xml.Machinable 'true' # for Service=ALL
          end
        end
      end
    end

  end
end
