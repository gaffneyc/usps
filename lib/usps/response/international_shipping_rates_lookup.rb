module USPS::Response
  class InternationalShippingRatesLookup < Base
    attr_reader :packages

    def initialize(xml)
      @packages = []
      xml.search('Package').each do |package_node|
        @packages << Package::InternationalPackage.new do |package|
          package.id       = package_node.attr('ID')
          package.services = package_node.search('Service').map do |postage|
            parse_service(postage)
          end
        end
      end
    end

    private

    def parse_service(node)
      Package::InternationalPackage::Service.new.tap do |service|
        service.id           = node.attr('ID')
        service.description  = node.search('SvcDescription').text
        service.rate         = node.search('Postage').text
      end
    end
  end
end
