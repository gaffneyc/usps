module USPS::Response
  class CityAndStateLookup < Base
    # Result record for a city and state lookup.
    class Result < Struct.new(:zip, :city, :state); end

    def initialize(xml)
      @data = {}

      xml.search('ZipCode').each do |node|
        zip = node.search('Zip5').text.to_i

        @data[zip] = Result.new(
          zip,
          node.search('City').text,
          node.search('State').text
        )
      end
    end

    # Returns an address representing the standardized version of the given
    # address from the results of the query.
    def get(zip)
      @data[zip.to_i]
    end
    alias :[] :get
  end
end

