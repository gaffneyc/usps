module USPS::Request
  # Given a valid USPS tracking number, use this class to request
  # tracking information from USPS's systems.
  #
  # Returns a USPS::Response::TrackingLookup object with the pertinent
  # information
  class TrackingLookup < Base
    config(
      :api => 'TrackV2',
      :tag => 'TrackRequest',
      :secure => false,
      :response => USPS::Response::TrackingLookup
    )

    # Build a new TrackingLookup request.
    # Takes the USPS tracking number to request information for
    def initialize(track_id)
      @track_id = track_id
    end

    def build
      super do |builder|
        builder.tag!('TrackID', :ID => @track_id)
      end
    end

  end
end
