module USPS::Response
  # Response object from a USPS::Request::TrackingLookup request. 
  # Includes a summary of the current status of the shipment, along with
  # an array of details of the shipment's progress
  class TrackingFieldLookup < Base

    attr_accessor :summary, :details


    def initialize(xml)
       @summary = parse(xml.search("TrackSummary"))
       @details = []
       xml.search("TrackDetail").each do |detail|
         @details << parse(detail)
       end
     end
     
     private
     def parse(node)
       USPS::TrackDetail.new(
         :event_time => node.search('EventTime').text,
         :event_date => node.search('EventDate').text,
         :event => node.search('Event').text,
         :event_city => node.search('EventCity').text,
         :event_state => node.search('EventState').text,
         :event_zip_code => node.search('EventZIPCode').text,
         :event_country => node.search('EventCountry').text,
         :firm_name => node.search('FirmName').text,
         :name => node.search('Name').text,
         :authorized_agent => node.search('AuthorizedAgent').text
       )
     end
  end
end
