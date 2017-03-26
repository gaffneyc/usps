module USPS::Response
  # Response object from a USPS::Request::MultiTrackingFieldLookup request.
  # Contains a hash mapping requested IDs to TrackingFieldLookups.
  class MultiTrackingFieldLookup < Base
    attr_accessor :tracking_infos

    def initialize(xml)
      @tracking_infos = {}
      xml.search("TrackInfo").each do |info_node|
        tracking_id = info_node["ID"]
        tracking_info = USPS::Response::TrackingFieldLookup.new(info_node)
        @tracking_infos[tracking_id] = tracking_info
      end
    end
  end
end
