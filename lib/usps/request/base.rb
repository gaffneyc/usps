module USPS::Request
  class Base
    class << self
      attr_reader :api, :tag, :response

      # Config given
      #   api: The USPS API name as given in the request URL
      #   tag: The root tag used for the request
      #   response: The USPS::Response class used to handle responses
      def config(options = {})
        @api = options[:api].to_s
        @tag = options[:tag].to_s
        @response = options[:response]
      end
    end

    def send!
      USPS.client.request(self)
    end

    def api
      self.class.api
    end

    def response_for(xml)
      self.class.response.parse(xml)
    end

    def build(&block)
      builder = Builder::XmlMarkup.new(:indent => 0)
      builder.tag!(self.class.tag, :USERID => USPS.config.username, &block)
    end
  end
end
