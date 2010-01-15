require 'cgi'
require 'net/https'

module USPS
  class Client
    attr_accessor :testing

    # TODO: Needs to handle timeouts
    def request(request, &block)
      port = request.secure? ? 443 : 80
      server = server(request)

      http = Net::HTTP.new(server, port)

      # TODO: Consider verifying the USPS SSL certificate
      if(request.secure?)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      # TODO: Consider other http clients as net/http is slow
      # NOTE: The USPS also supports POST and may be a better alternative but
      #       during initial testing it appears to take twice as long per request
      #       and I am not sure if the slow down is on their end or ours.
      response =
        http.start do
          http.get("/#{path}?API=#{request.api}&XML=#{CGI.escape(request.build)}")
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

    private
    def path
      @testing ? "ShippingAPITest.dll" : "ShippingAPI.dll"
    end

    def server(request)
      case
      when request.secure?
        "secure.shippingapis.com"
      when @testing
        "testing.shippingapis.com"
      else
        "production.shippingapis.com"
      end
    end
  end
end
