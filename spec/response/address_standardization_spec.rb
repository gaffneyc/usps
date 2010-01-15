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

    standard.address.should == '6406 IVY LN'
    standard.city.should == 'GREENBELT'
    standard.state.should == 'MD'
    standard.zip.should == '20770-1441'
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

    standard.address.should == '8 WILDWOOD DR'
    standard.city.should == 'OLD LYME'
    standard.state.should == 'CT'
    standard.zip.should == '06371-1844'
  end

  it "should propogate name to the result address as it is not returned from api" do
    address = USPS::Address.new(
      :name => 'Carl Sagan'
    )

    response = USPS::Response::AddressStandardization.new(
      address, load_xml('address_standardization_2.xml')
    )

    response.get(address).name.should == 'Carl Sagan'
  end
end
