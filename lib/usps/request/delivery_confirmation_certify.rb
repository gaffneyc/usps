module USPS::Request
  class DeliveryConfirmationCertify < USPS::Request::DeliveryConfirmation
    config(
      :api => 'DelivConfirmCertifyV3',
      :tag => 'DelivConfirmCertifyV3.0Request',
      :secure => true,
      :response => USPS::Response::DeliveryConfirmation
    )
  end
end
