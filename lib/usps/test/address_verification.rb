class USPS::Test
  module AddressVerification
    def test_address_standardization_1
      address = USPS::Address.new(
        :address => '6406 Ivy Lane',
        :city => 'Greenbelt',
        :state => 'MD'
      ).standardize!
      
      assert_equal '6406 IVY LN', address.address
      assert_equal 'GREENBELT', address.city
      assert_equal 'MD', address.state
      assert_equal '20770', address.zip5
      assert_equal '1440', address.zip4
    end

    def test_address_standardization_2
      address = USPS::Address.new(
        :address => '8 Wildwood Drive',
        :city => 'Old Lyme',
        :state => 'CT'
      ).standardize!

      assert_equal '8 WILDWOOD DR', address.address
      assert_equal 'OLD LYME', address.city
      assert_equal 'CT', address.state
      assert_equal '06371', address.zip5
      assert_equal '1844', address.zip4
    end
  end
end
