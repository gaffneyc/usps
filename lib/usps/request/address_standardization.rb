module USPS::Request
  # TODO: #send! could be made smarter to send lookup batches
  class AddressStandardization < Base
    config(
      :api => 'Verify',
      :tag => 'AddressValidateRequest',
      :secure => false,
      :response => USPS::Response::AddressStandardization
    )

    # At most 5 addresses can be verified
    def initialize(*addresses)
      @addresses = addresses.flatten

      if @addresses.size > 5
        raise ArgumentError, 'at most 5 addresses can be verified at a time'
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

            # Address fields are swapped in the USPS API
            builder.tag!('Address1', addy.extra_address)
            builder.tag!('Address2', addy.address)

            builder.tag!('City', addy.city)
            builder.tag!('State', addy.state)

            builder.tag!('Zip5', addy.zip5)
            builder.tag!('Zip4', addy.zip4)
          end
        end
      end
    end
  end
end
