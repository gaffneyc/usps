require 'spec_helper'

describe USPS::Request::Base do
  class RequestSubclassForTesting < USPS::Request::Base
    config(:api => 'testing', :tag => 'TestingTag')
  end

  it "should prepend the configured tag and USPS username" do
    sub = RequestSubclassForTesting.new

    xml = Nokogiri::XML.parse(sub.build)

    expect(xml.root.name).to eq('TestingTag')
    expect(xml.root.attr('USERID')).to eq(USPS.username)
  end
end
