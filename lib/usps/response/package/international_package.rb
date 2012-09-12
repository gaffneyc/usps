module USPS::Response::Package
  class InternationalPackage
    class Service
      attr_accessor :id, :description, :rate
    end

    attr_accessor :id
    attr_accessor :origin_zip, :destination_zip
    attr_accessor :pounds, :ounces, :container, :size

    attr_accessor :services

    def initialize(properties = {})
      properties.each_pair { |k, v| send("#{k}=", v) }
      yield self if block_given?
    end
  end
end
