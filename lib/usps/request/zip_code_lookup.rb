module USPS::Request
  # This class is essentially identical to AddressStandardization but do to how
  # #build inheritance is being done it's easier just to reimplement it for now.
  #
  # TODO: #send! could be made smarter to send lookup batches
  class ZipCodeLookup < Base
    config(
      :api => 'ZipCodeLookup',
      :tag => 'ZipCodeLookupRequest',
      :secure => false,
      :response => USPS::Response::AddressStandardization
    )

    # At most 5 zip codes can be retrieved at once
    def initialize(*addresses)
      @addresses = addresses

      if @addresses.size > 5
        raise ArgumentError, 'at most 5 lookups can be performed per request'
      end
    end

    def response_for(xml)
      self.class.response.new(@addresses, xml)
    end

    def build
      super do |builder|
        @addresses.each_with_index do |addy, i|
          builder.tag!('Address', :ID => i) do
            builder.tag!('FirmName', addy.firm)

            # Address 1 and 2 are backwards compared to how they appear on an
            # envelope.
            builder.tag!('Address1', addy.extra_address)
            builder.tag!('Address2', addy.address)

            builder.tag!('City', addy.city)
            builder.tag!('State', addy.state)
          end
        end
      end
    end
  end
end
