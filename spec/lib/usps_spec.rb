require 'spec_helper'

describe USPS do
  it "should allow setting the USPS API username" do
    USPS.username = 'melvin'
    expect(USPS.username).to eq('melvin')
  end
end
