module USPS::Request
  class DeliveryConfirmationCertify < USPS::Request::DeliveryConfirmation
    config(
      :api => 'DelivConfirmCertifyV3',
      :tag => 'DelivConfirmCertifyV3.0Request',
      :response => USPS::Response::DeliveryConfirmation
    )
  end
end
