require 'spec_helper'

describe USPS::Request::TrackingLookup do

  it 'should be using the proper USPS api settings' do
    USPS::Request::TrackingLookup.tap do |klass|
      klass.secure.should be_false
      klass.api.should == 'TrackV2'
      klass.tag.should == 'TrackRequest'
    end
  end

  it "should build a proper request" do
    request = USPS::Request::TrackingLookup.new("EJ958083578US").build

    xml = Nokogiri::XML.parse(request)
    xml.search('TrackID').text.should == ''
    xml.search('TrackID').attr("ID").text.should == "EJ958083578US"
  end

end
