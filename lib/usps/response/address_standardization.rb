# TODO: AddressStandardization _can_ handle up to 5 addresses at once and each
#       can be valid or error out. Currently the system raises an exception if any
#       are invalid. The error should be by address.
module USPS::Response
  class AddressStandardization < Base
    def initialize(addresses, xml)
      @addresses = {}

      [addresses].flatten.each_with_index do |addy, i|
        @addresses[addy] = parse(xml.search("Address[@ID='#{i}']"))

        # Name is not sent nor received so lets make sure to set it so the
        # standardized version is roughly equivalent
        @addresses[addy].name = addy.name
      end
    end

    # Returns an address representing the standardized version of the given
    # address from the results of the query.
    def get(address)
      @addresses[address]
    end
    alias :[] :get

    private
    def parse(node)
      USPS::Address.new(
        :company => node.search('FirmName').text,
        :address1 => node.search('Address2').text,
        :address2 => node.search('Address1').text,
        :city => node.search('City').text,
        :state => node.search('State').text,
        :zip5 => node.search('Zip5').text,
        :zip4 => node.search('Zip4').text
      )
    end
  end
end
