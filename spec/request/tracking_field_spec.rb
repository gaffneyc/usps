require 'spec_helper'

describe USPS::Request::TrackingFieldLookup do

  it 'should be using the proper USPS api settings' do
    USPS::Request::TrackingFieldLookup.tap do |klass|
      klass.secure.should be_false
      klass.api.should == 'TrackV2'
      klass.tag.should == 'TrackFieldRequest'
    end
  end

  it "should build a proper request" do
    request = USPS::Request::TrackingFieldLookup.new("EJ958083578US").build
    xml = Nokogiri::XML.parse(request)
    xml.search('TrackID').text.should == ''
    xml.search('TrackID').attr("ID").text.should == "EJ958083578US"
  end

end
