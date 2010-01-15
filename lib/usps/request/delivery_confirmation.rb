module USPS::Request
  class DeliveryConfirmation < Base
    config(
      :api => 'DeliveryConfirmationV3',
      :tag => 'DeliveryConfirmationV3.0Request',
      :secure => true,
      :response => USPS::Response::DeliveryConfirmation
    )

    attr_reader :to, :from, :weight, :options, :format

    DEFAULTS = {
      :type    => 1,
      :format  => 'TIF',
      :service => 'Priority'
    }.freeze

    # List of valid options and their mapping to their tag
    OPTIONS = {
      :type               => 'Option',
      :service            => 'ServiceType',
      :po_zip_code        => 'PoZipCode',
      :label_date         => 'LabelDate',
      :customer_reference => 'CustomerRefNo',
      :separate_receipt   => 'SeparateReceiptPage',
      :address_service    => 'AddressServiceRequested',
      :sender_name        => 'SenderName',
      :sender_email       => 'SenderEMail',
      :recipient_name     => 'RecipientName',
      :recipient_email    => 'RecipientEMail'
    }.freeze

    FORMATS = %w(TIF PDF).freeze

    # === Options:
    # * <tt>:
    def initialize(to, from, weight, options = {})
      @to = to
      @from = from
      @weight = weight
      @options = DEFAULTS.merge(options)

      @type = @options.delete(:type)
      self.format = @options.delete(:format)
    end

    def format=(format)
      format = format.upcase

      unless(FORMATS.include?(format))
        raise ArgumentError, "Format must be one of #{FORMATS.join(',')}"
      end

      @format = format.upcase
    end

    def build
      super do |builder|
        builder.tag!('Option', @type)
        builder.tag!('ImageParameters')

        [
          [self.from, 'From'],
          [self.to,   'To']
        ].each do |address, prefix|
          builder.tag!("#{prefix}Name",  address.name)
          builder.tag!("#{prefix}Firm",  address.company)
          builder.tag!("#{prefix}Address1", address.extra_address)
          builder.tag!("#{prefix}Address2", address.address)
          builder.tag!("#{prefix}City",  address.city)
          builder.tag!("#{prefix}State", address.state)
          builder.tag!("#{prefix}Zip5",  address.zip5)
          builder.tag!("#{prefix}Zip4",  address.zip4)
        end

        builder.tag!('WeightInOunces', self.weight)

        @options.each_pair do |k,v|
          OPTIONS[k].tap do |tag|
            builder.tag!(tag, v.to_s) if tag
          end
        end

        builder.tag!('ImageType', @format)
      end
    end
  end
end
