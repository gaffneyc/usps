module USPS::Request::Package
  class DomesticPackage < Base
    attr_accessor :service
    attr_accessor :first_class_mail_type
    attr_accessor :origin_zip, :destination_zip
    attr_accessor :value
    attr_accessor :amount_to_collect

    @@required += [:service, :origin_zip, :destination_zip]

    def initialize(fields = {})
      if fields[:service] == 'FIRST CLASS' and !fields[:first_class_mail_type]
        error "first_class_mail_type is required when Service=FIRST Class"
      end
      super
    end
  end
end
