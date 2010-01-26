class USPS::Test
  module TrackingLookup
    def test_tracking_lookup_1
      tracker_id = "EJ958083578US"
      request = USPS::Request::TrackingLookup.new(tracker_id)
      results = request.send!

      assert_equal "Your item was delivered at 8:10 am on June 1 in Wilmington DE 19801.", results.summary
      assert_equal 3, results.details.length

      assert_equal "May 30 11:07 am NOTICE LEFT WILMINGTON DE 19801.", results.details[0]
      assert_equal "May 30 10:08 am ARRIVAL AT UNIT WILMINGTON DE 19850.", results.details[1]
      assert_equal "May 29 9:55 am ACCEPT OR PICKUP EDGEWATER NJ 07020.", results.details[2]
    end

    def test_tracking_lookup_2
      tracker_id = "EJ958088694US"
      request = USPS::Request::TrackingLookup.new(tracker_id)
      results = request.send!

      assert_equal "Your item was delivered at 1:39 pm on June 1 in WOBURN MA 01815.", results.summary
      assert_equal 3, results.details.length

      assert_equal "May 30 7:44 am NOTICE LEFT WOBURN MA 01815.", results.details[0]
      assert_equal "May 30 7:36 am ARRIVAL AT UNIT NORTH READING MA 01889.", results.details[1]
      assert_equal "May 29 6:00 pm ACCEPT OR PICKUP PORTSMOUTH NH 03801.", results.details[2]
    end
  end
end
