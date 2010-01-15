require 'spec_helper'

describe USPS::Response::DeliveryConfirmation do
  it "should handle test request 1" do
    response = USPS::Response::DeliveryConfirmation.new(
      load_xml('delivery_confirmation_1.xml')
    )

    response.confirmation.should == '420381199101805213907126809651'
    response.label.should == 'LABEL DATA GOES HERE'
    response.postnet.should == '38119571851'

    # Check the address
    addy = response.address
    addy.name.should == 'Joe Customer'
    addy.address.should == '6060 PRIMACY PKWY'
    addy.address2.should == 'STE 201'
    addy.city.should == 'Memphis'
    addy.state.should == 'TN'
    addy.zip.should == '38119-5718'
  end

  # TODO: Test is still missing custom fields
  it "should handle test request 2" do
    response = USPS::Response::DeliveryConfirmation.new(
      load_xml('delivery_confirmation_2.xml')
    )

    response.confirmation.should == '420381199101805213907116323891'
    response.label.should == 'LABEL DATA GOES HERE'
    response.postnet.should == '38119571851'

    # Check the address
    addy = response.address
    addy.company.should == 'U.S. Postal Service NCSC'
    addy.name.should == 'Joe Customer'
    addy.address.should == '6060 PRIMACY PKWY'
    addy.address2.should == 'STE 201'
    addy.city.should == 'MEMPHIS'
    addy.state.should == 'TN'
    addy.zip.should == '38119-5718'
  end
end
