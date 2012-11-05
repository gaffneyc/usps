class USPS::TrackInfo < Struct.new(:track_id, :track_summary, :track_detail)
  attr_reader :error

  def initialize(options = {}, &block)
    options.each_pair do |k, v|
      self.send("#{k}=", v)
    end

    block.call(self) if block
  end
end
