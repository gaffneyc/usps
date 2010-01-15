module USPS::Request
  autoload :Base, 'usps/request/base'
  autoload :ZipCodeLookup, 'usps/request/zip_code_lookup'
  autoload :CityAndStateLookup,     'usps/request/city_and_state_lookup'
  autoload :AddressStandardization, 'usps/request/address_standardization'

  # Delivery and Signature confirmation.
  # DeliveryConfirmationCertify and SignatureConfirmationCertify should be used for testing
  autoload :DeliveryConfirmation, 'usps/request/delivery_confirmation'
  autoload :DeliveryConfirmationCertify, 'usps/request/delivery_confirmation_certify'
end
