module USPS::Response::Package
  class DomesticPackage
    class Postage
      attr_accessor :rate, :mail_service, :class_id
    end

    attr_accessor :postages
    attr_accessor :id, :origin_zip, :destination_zip, :pounds, :ounces, :container, :size

    def initialize(properties = {})
      properties.each_pair { |k, v| send("#{k}=", v) }
      yield self if block_given?
    end
  end
end
