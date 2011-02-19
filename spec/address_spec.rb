require 'spec_helper'

describe USPS::Address do
  it "should have the expected fields" do
    address = USPS::Address.new

    address.should respond_to(
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

    address.name.should == 'Chris'
    address.address.should == '123 Main St'
    address.city.should == 'Holland'
  end

  it "know how to combine the zip coes" do
    USPS::Address.new(:zip5 => 12345).zip.should == '12345'
    USPS::Address.new(:zip5 => 12345, :zip4 => 9999).zip.should == '12345-9999'
  end

  it "should be able to parse zip into individual parts" do
    addy = USPS::Address.new(:zip => '12345-9988')
    addy.zip5.should == '12345'
    addy.zip4.should == '9988'
    addy.zip.should  == '12345-9988'
  end

  it "should be able to be verified with the USPS" do
    addy = USPS::Address.new(
      :name => 'President Lincoln',
      :address => '1600 Pennsylvania Avenue NW',
      :city => 'Washington',
      :state => 'DC',
      :zip => 20006
    )

    USPS.client.should_receive(:request).and_return(
      USPS::Response::AddressStandardization.new(
        addy, load_xml('address_standardization_1.xml')
      )
    )

    addy.valid?.should be_true

    error = USPS::Error.new('error', '1234', 'source')
    # Failure
    USPS.client.should_receive(:request).and_raise(error)
    addy.valid?.should be_false
    addy.error.should be(error)
  end
end
