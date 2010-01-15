require 'spec_helper'

describe USPS::Response::CityAndStateLookup do
  it "should handle test request 1" do
    response = USPS::Response::CityAndStateLookup.new(
      load_xml('city_and_state_lookup_1.xml')
    )

    response.get(90210).tap do |r|
      r.zip.should   == 90210
      r.city.should  == 'BEVERLY HILLS'
      r.state.should == 'CA'
    end
  end

  it "should handle test request 2" do
    response = USPS::Response::CityAndStateLookup.new(
      load_xml('city_and_state_lookup_2.xml')
    )

    response.get(20770).tap do |r|
      r.zip.should   == 20770
      r.city.should  == 'GREENBELT'
      r.state.should == 'MD'
    end
  end
end
