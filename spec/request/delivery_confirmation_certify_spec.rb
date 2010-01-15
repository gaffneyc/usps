require 'spec_helper'

describe USPS::Request::DeliveryConfirmationCertify do
  it 'should be using the proper USPS api settings' do
    USPS::Request::DeliveryConfirmationCertify.tap do |klass|
      klass.secure.should be_true
      klass.api.should == 'DelivConfirmCertifyV3'
      klass.tag.should == 'DelivConfirmCertifyV3.0Request'
    end
  end
end
