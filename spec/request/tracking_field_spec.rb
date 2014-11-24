require 'spec_helper'

describe USPS::Request::TrackingFieldLookup do

  it 'should be using the proper USPS api settings' do
    USPS::Request::TrackingFieldLookup.tap do |klass|
      expect(klass.secure).to be_falsey
      expect(klass.api).to eq('TrackV2')
      expect(klass.tag).to eq('TrackFieldRequest')
    end
  end

  it "should build a proper request" do
    request = USPS::Request::TrackingFieldLookup.new("EJ958083578US").build
    xml = Nokogiri::XML.parse(request)
    expect(xml.search('TrackID').text).to eq('')
    expect(xml.search('TrackID').attr("ID").text).to eq("EJ958083578US")
  end

end
