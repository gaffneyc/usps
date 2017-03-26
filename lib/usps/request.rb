module USPS::Request
  autoload :Base, 'usps/request/base'
  autoload :ZipCodeLookup, 'usps/request/zip_code_lookup'
  autoload :CityAndStateLookup,     'usps/request/city_and_state_lookup'
  autoload :AddressStandardization, 'usps/request/address_standardization'

  # Delivery and Signature confirmation.
  # DeliveryConfirmationCertify and SignatureConfirmationCertify should be used for testing
  autoload :DeliveryConfirmation, 'usps/request/delivery_confirmation'
  autoload :DeliveryConfirmationCertify, 'usps/request/delivery_confirmation_certify'

  autoload :TrackingLookup,      'usps/request/tracking_lookup'
  autoload :TrackingFieldLookup, 'usps/request/tracking_field_lookup'
  autoload :MultiTrackingFieldLookup, 'usps/request/multi_tracking_field_lookup'
end
