module USPS::Response
  # Response object from a USPS::Request::TrackingLookup request. 
  # Includes a summary of the current status of the shipment, along with
  # an array of details of the shipment's progress
  class TrackingLookup < Base

    attr_accessor :summary, :details

    def initialize(xml)
      @summary = xml.search("TrackSummary").text

      @details = []
      xml.search("TrackDetail").each do |detail|
        @details << detail.text
      end
    end

  end
end
