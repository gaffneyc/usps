class USPS::Test
  # This module is here only for completeness. The USPS test server does not
  # currently support the label printing APIs despite what the documentation
  # says.
  module DeliveryConfirmation
    def test_delivery_confirmation_1
      from = USPS::Address.new(
        :name => 'John Smith',
        :address => "475 L'Enfant Plaza, SW",
        :city => 'Washington',
        :state => 'DC',
        :zip => '20260'
      )

      to = USPS::Address.new(
        :name => 'Joe Customer',
        :address => '6060 PRIMACY PKWY',
        :address2 => 'STE 201',
        :state => 'TN',
        :city => 'MEMPHIS'
      )

      request = USPS::Request::DeliveryConfirmationCertify.new(to, from, 2)
      request.send!
    end

    def test_delivery_confirmation_2
      from = USPS::Address.new(
        :name => 'John Smith',
        :company => 'U.S. Postal Headquarters',
        :address => "475 L'Enfant Plaza, SW",
        :city => 'Washington',
        :state => 'DC',
        :zip => '20260-0004'
      )

      to = USPS::Address.new(
        :name => 'Joe Customer',
        :address => '6060 PRIMACY PKWY',
        :address2 => 'STE 201',
        :state => 'TN',
        :city => 'MEMPHIS',
        :zip => '38119-5718'
      )

      options = {
        :service_type => 'Priority',
        :po_zip_code => 20260,
        :format => 'tif',
        :label_date => '07/08/2004',
        :customer_reference => 'A45-3928',
        :address_service => true
      }

      request = USPS::Request::DeliveryConfirmationCertify.new(to, from, 2, options)
      request.send!
    end
  end
end
