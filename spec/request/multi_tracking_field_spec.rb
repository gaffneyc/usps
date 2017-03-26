require 'spec_helper'

describe USPS::Request::MultiTrackingFieldLookup do

  it 'should be using the proper USPS api settings' do
    USPS::Request::TrackingFieldLookup.tap do |klass|
      klass.secure.should be_false
      klass.api.should == 'TrackV2'
      klass.tag.should == 'TrackFieldRequest'
    end
  end

  it "should build a proper request" do
    request = USPS::Request::MultiTrackingFieldLookup.new("EJ958083578US", "ABCDEFG123456").build
    xml = Nokogiri::XML.parse(request)
    xml.search('TrackingFieldRequest').should be
    xml.search('TrackID')[0].attr('ID').should == "EJ958083578US"
    xml.search('TrackID')[1].attr('ID').should == "ABCDEFG123456"
  end

end
