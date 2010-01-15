module USPS::Response
  class Base
    attr_accessor :raw

    class << self
      def parse(xml)
        response = self.new(xml)
        response.raw = xml
        response
      end
    end
  end
end
