require 'time'
# TODO: Documentation
#
class USPS::TrackDetail < Struct.new(:event_time, :event_date, :event, :event_city, :event_state, :event_zip_code, :event_country, :firm_name, :name, :authorized_agent)

  # Alias address getters and setters for a slightly more expressive api
  alias :city  :event_city
  alias :city= :event_city=
  alias :state :event_state
  alias :state= :event_state=
  alias :zip_code :event_zip_code
  alias :zip_code= :event_zip_code=
  alias :country :event_country
  alias :country= :event_country=

  attr_reader :error

  def initialize(options = {}, &block)
    options.each_pair do |k, v|
      self.send("#{k}=", v)
    end

    block.call(self) if block
  end
  
  def date
    time = "#{event_date} #{event_time}".strip
    begin
      Time.parse(time) unless time.empty?
    rescue ArgumentError
      return nil
    end
  end

  # Similar to Hash#replace, overwrite the values of this object with the other.
  # It will not replace a provided key on the original object that does not exist
  # on the replacing object (such as name with verification requests).
  def replace(other)
    raise ArgumentError unless other.is_a?(USPS::Address)

    other.each_pair do |key, val|
      # Do not overwrite values that may exist on the original but not on
      # the replacement.
      self[key] = val unless val.nil?
    end

    self
  end
end
