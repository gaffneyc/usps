require 'spec_helper'

describe USPS::Configuration do
  before(:each) do
    ENV['USPS_USER'] = nil
    @config = USPS::Configuration.new
  end

  it "should have some sensible defaults" do
    expect(@config.username).to be_nil
    expect(@config.timeout).to eq(5)
    expect(@config.testing).to be_falsey
  end

  it "should grab the username from the environment if available" do
    ENV['USPS_USER'] = 'malcom77'
    expect(USPS::Configuration.new.username).to eq('malcom77')
  end
end
