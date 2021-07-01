require 'typhoeus'

module USPS
  class Client
    def request(request, &block)
      server = server(request)

      # Make the API request to the USPS servers. Used to support POST, now it's
      # just GET request *grumble*.
      response = Typhoeus::Request.get(server, {
        :timeout => USPS.config.timeout,
        :params => {
          "API" => request.api,
          "XML" => request.build
        }
      })

      if response.timed_out?
        raise TimeoutError
      end

      # If there are services that are down or there is no network connection available then
      # the request may not time out but instead return a blank body and a response_code of 0.
      #
      # The Typhoeus return_code might be :couldnt_connect or :couldnt_resolve_host rather than
      # :operation_timedout.
      #
      # In any case a response_code of 0 is exceptional so we raise an exception.
      #
      if response.response_code == 0
        raise ConnectionError
      end

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

    def server(_request)
      dll = testing? ? "ShippingAPITest.dll" : "ShippingAPI.dll"
      "https://production.shippingapis.com/#{dll}"
    end
  end
end
