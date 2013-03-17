require 'httparty'

module USPS
  class Client
    include HTTParty
    format :xml
    debug_output

    def request(request, &block)
      server = server(request)

      # Make the API request to the USPS servers. Used to support POST, now it's
      # just GET request *grumble*.
      response = self.class.get(server, :query => {'API' => request.api, 'XML' => request.build})

      # Parse the request
      xml = Nokogiri::XML.parse(response.body)

      # Process and raise errors
      if((error = xml.search('Error')).any?)
        # This is where things get a little tricky. There are a bunch of errors
        # that the USPS can send back.
        why = error.search('Description').text
        code = error.search('Number').text
        source = error.search('Source').text

        raise Error.for_code(code).new(why, code, source)
      end

      # Initialize the proper response object and parse the message
      request.response_for(xml)
    end

    def testing?
      USPS.config.testing
    end

    private
    def server(request)
      dll = testing? ? "ShippingAPITest.dll" : "ShippingAPI.dll"

      case
      when request.secure?
        "https://secure.shippingapis.com/#{dll}"
      when testing?
        "http://testing.shippingapis.com/#{dll}"
      else
        "http://production.shippingapis.com/#{dll}"
      end
    end
  end
end
