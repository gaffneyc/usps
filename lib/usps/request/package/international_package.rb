module USPS::Request::Package
  class InternationalPackage < Base
    attr_accessor :country, :mail_type

    @@required += [:country, :mail_type]

    def initialize(fields = {})
      super
    end
  end
end
