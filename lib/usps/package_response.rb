module USPS

  class PackageResponse < Struct.new(:id, :origin_zip, :destination_zip, :pounds, :ounces, :container, :size)

    attr_accessor :postages

    def initialize(properties = {})
      properties.each_pair { |k, v| send("#{k}=", v) }
      yield self if block_given?
    end

  end

end
