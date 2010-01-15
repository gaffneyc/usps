class USPS::Test
  module CityAndStateLookup
    def test_city_and_state_lookup_1
      data = USPS.get_city_and_state_for_zip(90210)
      
      assert_equal 90210, data[:zip]
      assert_equal 'BEVERLY HILLS', data[:city]
      assert_equal 'CA', data[:state]
    end

    def test_city_and_state_lookup_2
      data = USPS.get_city_and_state_for_zip(20770)
      
      assert_equal 20770, data.zip
      assert_equal 'GREENBELT', data.city
      assert_equal 'MD', data.state
    end
  end
end
