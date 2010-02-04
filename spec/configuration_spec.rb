require 'spec_helper'

describe USPS::Configuration do
  before(:each) do
    ENV['USPS_USER'] = nil
    @config = USPS::Configuration.new
  end

  it "should have some sensible defaults" do
    @config.username.should be_nil
    @config.timeout.should == 5
    @config.testing.should be_false
  end

  it "should grab the username from the environment if available" do
    ENV['USPS_USER'] = 'malcom77'
    USPS::Configuration.new.username.should == 'malcom77'
  end
end
