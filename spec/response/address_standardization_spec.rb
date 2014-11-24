require 'spec_helper'

describe USPS::Response::AddressStandardization do
  it "should handle test request 1" do
    address = USPS::Address.new(
      :address => '6406 Ivy Lane',
      :city => 'Greenbelt',
      :state => 'MD'
    )

    response = USPS::Response::AddressStandardization.new(
      address, load_xml('address_standardization_1.xml')
    )

    standard = response.get(address)

    expect(standard.address).to eq('6406 IVY LN')
    expect(standard.city).to eq('GREENBELT')
    expect(standard.state).to eq('MD')
    expect(standard.zip).to eq('20770-1441')
  end

  it "should handle test request 2" do
    address = USPS::Address.new(
      :address => '8 Wildwood Dr',
      :city => 'Old Lyme',
      :state => 'CT',
      :zip => '06371'
    )

    response = USPS::Response::AddressStandardization.new(
      address, load_xml('address_standardization_2.xml')
    )

    standard = response.get(address)

    expect(standard.address).to eq('8 WILDWOOD DR')
    expect(standard.city).to eq('OLD LYME')
    expect(standard.state).to eq('CT')
    expect(standard.zip).to eq('06371-1844')
  end

  it "should propogate name to the result address as it is not returned from api" do
    address = USPS::Address.new(
      :name => 'Carl Sagan'
    )

    response = USPS::Response::AddressStandardization.new(
      address, load_xml('address_standardization_2.xml')
    )

    expect(response.get(address).name).to eq('Carl Sagan')
  end
end
