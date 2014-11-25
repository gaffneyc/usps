require 'spec_helper'

describe USPS::Request::DeliveryConfirmationCertify do
  it 'should be using the proper USPS api settings' do
    USPS::Request::DeliveryConfirmationCertify.tap do |klass|
      expect(klass.secure).to be_truthy
      expect(klass.api).to eq('DelivConfirmCertifyV3')
      expect(klass.tag).to eq('DelivConfirmCertifyV3.0Request')
    end
  end
end
