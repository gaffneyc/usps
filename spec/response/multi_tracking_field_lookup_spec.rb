require 'spec_helper'

describe USPS::Response::MultiTrackingFieldLookup do

  it "should handle test request" do
    response = USPS::Response::MultiTrackingFieldLookup.new(load_xml("multi_tracking_field_lookup.xml"))
    response.should be_a_kind_of(USPS::Response::MultiTrackingFieldLookup)

    tracking_infos = response.tracking_infos
    tracking_ids = tracking_infos.keys
    tracking_ids[0].should == "01805213907042762274"
    tracking_ids[1].should == "22205213907042762222"

    tracking_ids.count.should == 2
    tracking_infos[tracking_ids[0]].should be_a_kind_of(USPS::Response::TrackingFieldLookup)
    tracking_infos[tracking_ids[1]].should be_a_kind_of(USPS::Response::TrackingFieldLookup)
  end
end
