require 'spec_helper'

describe USPS::Response::TrackingFieldLookup do

  it "should handle test request" do
    response = USPS::Response::TrackingFieldLookup.new(load_xml("tracking_field_lookup.xml"))
    expect(response).to be_a_kind_of(USPS::Response::TrackingFieldLookup)
    
    expect(response.summary.event).to eq("DELIVERED")
    expect(response.summary.city).to eq("NEWTON")
    expect(response.summary.date).to eq(Time.parse("2001-05-21 12:12:00 -0400"))
    expect(response.summary.event_time).to eq("12:12 pm")
    expect(response.summary.event_date).to eq("May 21, 2001")
    expect(response.summary.event_state).to eq("IA")
    expect(response.summary.event_zip_code).to eq("50208")
    expect(response.summary.name).to eq("")
    expect(response.summary.firm_name).to eq("")
    expect(response.summary.authorized_agent).to eq("")
        
    expect(response.details.length).to eq(2)
    expect(response.details[0].event).to eq("ENROUTE")
    expect(response.details[1].event).to eq("ACCEPTANCE")
  end
  it "should handle no detail records" do
    response = USPS::Response::TrackingFieldLookup.new(load_xml("tracking_field_lookup_2.xml"))
    expect(response.details.length).to eq(0)  
  end
end
