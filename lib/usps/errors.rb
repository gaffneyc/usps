module USPS
  # Error Hierarchy
  #
  # StandardError
  #   USPS::Error
  #     USPS::TimeoutError
  #     USPS::AuthorizationError
  #     USPS::ValidationError
  #       USPS::InvalidCityError
  #       USPS::InvalidStateError
  #       USPS::AddressNotFoundError
  #       USPS::MultipleAddressError
  #       USPS::InvalidImageTypeError
  class Error < StandardError
    attr_reader :number, :source

    def initialize(message = nil, number = nil, source = nil)
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
        when '-2147218900'; InvalidImageTypeError
        else              ; Error
        end
      end
    end
  end

  class TimeoutError < Error; end
  class AuthorizationError < Error; end

  class ValidationError < Error; end
  class InvalidCityError < ValidationError; end
  class InvalidStateError < ValidationError; end
  class AddressNotFoundError < ValidationError; end
  class MultipleAddressError < ValidationError; end
  class InvalidImageTypeError < ValidationError; end
end
