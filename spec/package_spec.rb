require 'spec_helper'

describe USPS::Package do

  REQUIRED_PROPERTIES = {
    :id              => 3,
    :service         => 'PRIORITY',
    :origin_zip      => '20171',
    :destination_zip => '08540',
    :pounds          => 5,
    :ounces          => 4,
    :container       => 'VARIABLE',
    :size            => 'LARGE'
  }

  it "should be valid when all required properties are specified" do
    expect {
      package = USPS::Package.new(REQUIRED_PROPERTIES)
    }.to_not raise_exception
  end

  it "properties can be set in an initialization block" do
    package = USPS::Package.new(REQUIRED_PROPERTIES) do |p|
      p.size = "REGULAR"
    end
    package.size.should == "REGULAR"
  end

  REQUIRED_PROPERTIES.keys.each do |prop|
    it "requires #{prop}" do
      expect {
        package = USPS::Package.new(required_properties.dup.delete prop)
      }.to raise_exception
    end
  end

end
