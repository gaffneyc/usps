module USPS::Response
  class ShippingRatesLookup < Base
    attr_reader :packages

    def initialize(xml)
      @packages = []
      xml.search('Package').each do |package_node|
        @packages << Package::DomesticPackage.new do |package_response|
          package_response.postages        = package_node.search('Postage').map { |postage| parse_postage(postage) }
          package_response.id              = package_node.attr('ID')
          package_response.pounds          = package_node.search('Pounds').text
          package_response.ounces          = package_node.search('Ounces').text
          package_response.size            = package_node.search('Size').text
          package_response.container       = package_node.search('Container').text
          package_response.origin_zip      = package_node.search('ZipOrigination').text
          package_response.destination_zip = package_node.search('ZipDestination').text
        end
      end
    end

    private

    def parse_postage(node)
      Package::DomesticPackage::Postage.new.tap do |postage|
        postage.class_id     = node.attr('CLASSID')
        postage.mail_service = node.search('MailService').text
        postage.rate         = node.search('Rate').text
      end
    end
  end
end
