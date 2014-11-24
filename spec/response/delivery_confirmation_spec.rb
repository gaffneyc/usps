require 'spec_helper'

describe USPS::Response::DeliveryConfirmation do
  it "should handle test request 1" do
    response = USPS::Response::DeliveryConfirmation.new(
      load_xml('delivery_confirmation_1.xml')
    )

    expect(response.confirmation).to eq('420381199101805213907126809651')
    expect(response.label).to eq('LABEL DATA GOES HERE')
    expect(response.postnet).to eq('38119571851')

    # Check the address
    addy = response.address
    expect(addy.name).to eq('Joe Customer')
    expect(addy.address).to eq('6060 PRIMACY PKWY')
    expect(addy.address2).to eq('STE 201')
    expect(addy.city).to eq('Memphis')
    expect(addy.state).to eq('TN')
    expect(addy.zip).to eq('38119-5718')
  end

  # TODO: Test is still missing custom fields
  it "should handle test request 2" do
    response = USPS::Response::DeliveryConfirmation.new(
      load_xml('delivery_confirmation_2.xml')
    )

    expect(response.confirmation).to eq('420381199101805213907116323891')
    expect(response.label).to eq('LABEL DATA GOES HERE')
    expect(response.postnet).to eq('38119571851')

    # Check the address
    addy = response.address
    expect(addy.company).to eq('U.S. Postal Service NCSC')
    expect(addy.name).to eq('Joe Customer')
    expect(addy.address).to eq('6060 PRIMACY PKWY')
    expect(addy.address2).to eq('STE 201')
    expect(addy.city).to eq('MEMPHIS')
    expect(addy.state).to eq('TN')
    expect(addy.zip).to eq('38119-5718')
  end
end
