module USPS::Request
  # Given a number of valid USPS tracking number, use this class to batch
  # request tracking information for multiple tracking numbers from USPS's systems.
  #
  # Returns a USPS::Response::MultiTrackingFieldLookup object with the pertinent
  # information
  class MultiTrackingFieldLookup < Base
    config(
      :api => 'TrackV2',
      :tag => 'TrackFieldRequest',
      :secure => false,
      :response => USPS::Response::MultiTrackingFieldLookup
    )

    # Build a new TrackingLookup request.
    # Takes the USPS tracking number to request information for
    def initialize(*track_ids)
      @track_ids = track_ids
    end

    def build
      super do |builder|
        @track_ids.each do |track_id|
          builder.tag!('TrackID', :ID => track_id)
        end
      end
    end

  end

end
