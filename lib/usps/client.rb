require 'net/https'

module USPS
  class Client
    def request(request, &block)
      server = server(request)

      # Make the API request to the USPS servers. Used to support POST, now it's
      # just GET request *grumble*.
      uri = URI(server)
      uri.query = URI.encode_www_form(
        "API" => request.api,
        "XML" => request.build
      )

      response = get(uri)

      # Parse the request
      xml = Nokogiri::XML.parse(response)

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

    def get(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = USPS.config.timeout
      http.read_timeout = USPS.config.timeout
      http.ssl_timeout = USPS.config.timeout
      http.use_ssl = uri.scheme == 'https'
      http.request_get(uri.request_uri).body
    end

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
