require 'spec_helper'

describe USPS::Request::Base do
  class RequestSubclassForTesting < USPS::Request::Base
    config(:api => 'testing', :tag => 'TestingTag')
  end

  it "should prepend the configured tag and USPS username" do
    sub = RequestSubclassForTesting.new

    xml = Nokogiri::XML.parse(sub.build)

    xml.root.name.should == 'TestingTag'
    xml.root.attr('USERID').should == USPS.username
  end
end
