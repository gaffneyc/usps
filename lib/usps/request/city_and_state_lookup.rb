module USPS::Request
  # All the address information APIs are essentially identical
  class CityAndStateLookup < Base
    config(
      :api => 'CityStateLookup',
      :tag => 'CityStateLookupRequest',
      :secure => false,
      :response => USPS::Response::CityAndStateLookup
    )

    # Given a list of zip codes, looks up what city and state they are associated with.
    #
    # The USPS api is only capable of handling at most 5 zip codes per request.
    def initialize(*zip_codes)
      @zip_codes = zip_codes.flatten

      if(@zip_codes.size > 5)
        raise ArgumentError, 'at most 5 lookups can be performed per request'
      end
    end

    def build
      super do |builder|
        @zip_codes.each_with_index do |zip, i|
          builder.tag!('ZipCode', :ID => i) do
            builder.tag!('Zip5', zip)
          end
        end
      end
    end
  end
end
