require 'spec_helper'

module USPS::Request::Package
  describe USPS::Request::Package::InternationalPackage do
    VALID_PROPERTIES = {
      :id              => 3,
      :country         => "France",
      :mail_type       => "Package",
      :pounds          => 5,
      :ounces          => 4,
      :container       => 'RECTANGULAR',
      :size            => 'REGULAR'
    }

    VALID_PROPERTIES.keys.each do |prop|
      it "requires #{prop}" do
        expect {
          package = InternationalPackage.new(required_properties.dup.delete prop)
        }.to raise_exception
      end
    end

    it "properties can be set with an initialization hash and/or block" do
      package = InternationalPackage.new :id => 3, :country => "France" do |p|
        p.mail_type = "FlatRate"
        p.pounds    = 4
        p.ounces    = 0
        p.container = "RECTANGULAR"
        p.size      = "REGULAR"
      end

      package.id.should        == 3
      package.country.should   == "France"
      package.mail_type.should == "FlatRate"
      package.pounds.should    == 4
      package.ounces.should    == 0
      package.container.should == "RECTANGULAR"
      package.size.should      == "REGULAR"
    end
  end
end
