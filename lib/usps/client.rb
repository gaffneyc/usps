require 'typhoeus'

module USPS
  class Client
    def request(request, &block)
      server = server(request)

      # The USPS documentation shows all requests as being GET requests, but
      # the servers also appear to support POST. We're using POST here so we
      # don't need to escape the request and to keep from running into any
      # concerns with data length.
      response = Typhoeus::Request.post(server, {
        :timeout => USPS.config.timeout,
        :params => {
          "API" => request.api,
          "XML" => request.build
        }
      })

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
