module USPS
  # Error Hierarchy
  #
  # StandardError
  #   USPS::Error
  #     USPS::AuthorizationError
  #     USPS::ValidationError
  #       USPS::InvalidCityError
  #       USPS::InvalidStateError
  #       USPS::AddressNotFoundError
  #       USPS::MultipleAddressError
  class Error < StandardError
    attr_reader :number, :source

    def initialize(message, number, source)
      super(message)

      @number = number
      @source = source
    end

    class << self
      def for_code(code)
        case code
        when '80040b1a'   ; AuthorizationError
        when '-2147219400'; InvalidCityError
        when '-2147219401'; AddressNotFoundError
        when '-2147219402'; InvalidStateError
        when '-2147219403'; MultipleAddressError
        else              ; Error
        end
      end
    end
  end

  class AuthorizationError < Error; end

  class ValidationError < Error; end
  class InvalidCityError < ValidationError; end
  class InvalidStateError < ValidationError; end
  class AddressNotFoundError < ValidationError; end
  class MultipleAddressError < ValidationError; end
end
