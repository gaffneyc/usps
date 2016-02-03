require 'spec_helper'

describe USPS::Client do
  it 'sends request and processes response' do
    zip = 90210

    stub_request(:get, "http://production.shippingapis.com/ShippingAPI.dll?API=CityStateLookup&XML=%3CCityStateLookupRequest%20USERID=%22TESTING%22%3E%3CZipCode%20ID=%220%22%3E%3CZip5%3E90210%3C/Zip5%3E%3C/ZipCode%3E%3C/CityStateLookupRequest%3E").
      to_return(status: 200, body: load_data('city_and_state_lookup_1.xml'))

    client = USPS::Client.new
    request = USPS::Request::CityAndStateLookup.new(zip)
    response = client.request(request)
    expect(response.get(zip).city).to eq 'BEVERLY HILLS'
  end
end
