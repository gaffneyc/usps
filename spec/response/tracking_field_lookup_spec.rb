require 'spec_helper'

describe USPS::Response::TrackingFieldLookup do

  it "should handle test request" do
    response = USPS::Response::TrackingFieldLookup.new(load_xml("tracking_field_lookup.xml"))
    response.should be_a_kind_of(USPS::Response::TrackingFieldLookup)
    
    response.summary.event.should == "DELIVERED"
    response.summary.city.should == "NEWTON"
    response.summary.date.to_s.should == '2001-05-21 12:12:00 -0400'
    response.summary.event_time.should == "12:12 pm"
    response.summary.event_date.should == "May 21, 2001"
    response.summary.event_state.should == "IA"
    response.summary.event_zip_code.should == "50208"
    response.summary.name.should == ""
    response.summary.firm_name.should == ""
    response.summary.authorized_agent.should == ""
        
    response.details.length.should == 2
    response.details[0].event.should == "ENROUTE"
    response.details[1].event.should == "ACCEPTANCE"
  end
  it "should handle no detail records" do
    response = USPS::Response::TrackingFieldLookup.new(load_xml("tracking_field_lookup_2.xml"))
    response.details.length.should == 0  
  end
end
