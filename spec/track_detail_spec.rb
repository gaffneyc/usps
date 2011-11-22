require 'spec_helper'

describe USPS::TrackDetail do
  it "should have the expected fields" do
    track_detail = USPS::TrackDetail.new
    
    track_detail.should respond_to(
      :event_time, :event_time=,
      :event_date, :event_date=,
      :event, :event=,
      :event_city, :event_city=,
      :event_state, :event_state=,
      :event_zip_code, :event_zip_code=,
      :event_country, :event_country=,
      :firm_name, :firm_name=,
      :name, :name=,
      :authorized_agent, :authorized_agent=,
      :date)
  end

  it "should be initializable with a hash" do
    track_detail = USPS::TrackDetail.new(
      :name => 'Chris',
      :event_city => '123 Main St',
      :event => 'DELIVERED'
    )

    track_detail.name.should == 'Chris'
    track_detail.event_city.should == '123 Main St'
    track_detail.event.should == 'DELIVERED'
  end
  
  it "should calculate a date" do
    track_detail = USPS::TrackDetail.new(
      :event_time => '9:24 pm',
      :event_date => 'March 28, 2001',
    )
    track_detail.date.should == Time.parse('2001-03-28 21:24:00 -0500')

  end

end
