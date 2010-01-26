require 'spec_helper'

describe USPS::Response::TrackingLookup do

  it "should handle test request 1" do
    response = USPS::Response::TrackingLookup.new(load_xml("tracking_lookup_1.xml"))

    response.summary.should == "Your item was delivered at 8:10 am on June 1 in Wilmington DE 19801."
    response.details.length.should == 3

    response.details[0].should == "May 30 11:07 am NOTICE LEFT WILMINGTON DE 19801."
    response.details[1].should == "May 30 10:08 am ARRIVAL AT UNIT WILMINGTON DE 19850."
    response.details[2].should == "May 29 9:55 am ACCEPT OR PICKUP EDGEWATER NJ 07020."
  end

  it "should handle test request 2" do
    response = USPS::Response::TrackingLookup.new(load_xml("tracking_lookup_2.xml"))

    response.summary.should == "Your item was delivered at 1:39 pm on June 1 in WOBURN MA 01815."
    response.details.length.should == 3

    response.details[0].should == "May 30 7:44 am NOTICE LEFT WOBURN MA 01815."
    response.details[1].should == "May 30 7:36 am ARRIVAL AT UNIT NORTH READING MA 01889."
    response.details[2].should == "May 29 6:00 pm ACCEPT OR PICKUP PORTSMOUTH NH 03801."
  end

end
