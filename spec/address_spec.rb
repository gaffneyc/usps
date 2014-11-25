require 'spec_helper'

describe USPS::Address do
  it "should have the expected fields" do
    address = USPS::Address.new

    expect(address).to respond_to(
      :name, :name=,
      :address1, :address1=,
      :address2, :address2=,
      :city, :city=,
      :state, :state=,
      :zip5, :zip5=,
      :zip4, :zip4=
    )
  end

  it "should be initializable with a hash" do
    address = USPS::Address.new(
      :name => 'Chris',
      :address => '123 Main St',
      :city => 'Holland'
    )

    expect(address.name).to eq('Chris')
    expect(address.address).to eq('123 Main St')
    expect(address.city).to eq('Holland')
  end

  it "know how to combine the zip coes" do
    expect(USPS::Address.new(:zip5 => 12345).zip).to eq('12345')
    expect(USPS::Address.new(:zip5 => 12345, :zip4 => 9999).zip).to eq('12345-9999')
  end

  it "should be able to parse zip into individual parts" do
    addy = USPS::Address.new(:zip => '12345-9988')
    expect(addy.zip5).to eq('12345')
    expect(addy.zip4).to eq('9988')
    expect(addy.zip).to  eq('12345-9988')
  end

  it "should be able to be verified with the USPS" do
    addy = USPS::Address.new(
      :name => 'President Lincoln',
      :address => '1600 Pennsylvania Avenue NW',
      :city => 'Washington',
      :state => 'DC',
      :zip => 20006
    )

    expect(USPS.client).to receive(:request).and_return(
      USPS::Response::AddressStandardization.new(
        addy, load_xml('address_standardization_1.xml')
      )
    )

    expect(addy.valid?).to be_truthy

    error = USPS::Error.new('error', '1234', 'source')
    # Failure
    expect(USPS.client).to receive(:request).and_raise(error)
    expect(addy.valid?).to be_falsey
    expect(addy.error).to be(error)
  end
end
