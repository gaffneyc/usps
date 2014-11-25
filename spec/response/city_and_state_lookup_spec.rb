require 'spec_helper'

describe USPS::Response::CityAndStateLookup do
  it "should handle test request 1" do
    response = USPS::Response::CityAndStateLookup.new(
      load_xml('city_and_state_lookup_1.xml')
    )

    response.get(90210).tap do |r|
      expect(r.zip).to   eq(90210)
      expect(r.city).to  eq('BEVERLY HILLS')
      expect(r.state).to eq('CA')
    end
  end

  it "should handle test request 2" do
    response = USPS::Response::CityAndStateLookup.new(
      load_xml('city_and_state_lookup_2.xml')
    )

    response.get(20770).tap do |r|
      expect(r.zip).to   eq(20770)
      expect(r.city).to  eq('GREENBELT')
      expect(r.state).to eq('MD')
    end
  end
end
