module USPS::Response
  autoload :Base, 'usps/response/base'
  autoload :CityAndStateLookup,     'usps/response/city_and_state_lookup'
  autoload :DeliveryConfirmation,   'usps/response/delivery_confirmation'
  autoload :AddressStandardization, 'usps/response/address_standardization'
end
