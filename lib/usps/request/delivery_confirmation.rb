# TODO: Add support for the optional tags
module USPS::Request
  class DeliveryConfirmation < Base
    config(
      :api => 'DeliveryConfirmationV3',
      :tag => 'DeliveryConfirmationV3.0Request',
      :secure => true,
      :response => USPS::Response::DeliveryConfirmation
    )

    attr_reader :to, :from, :weight, :options

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
      :format             => lambda {|b,v| b.tag!('ImageType', v.to_s.upcase)},
      :separate_receipt   => lambda {|b,v| b.tag!('SeparateReceiptPage', v.to_s.upcase)},
      :address_service    => lambda {|b,v| b.tag!('AddressServiceRequested', v.to_s.upcase)},
      :sender_name        => 'SenderName',
      :sender_email       => 'SenderEMail',
      :recipient_name     => 'RecipientName',
      :recipient_email    => 'RecipientEMail'
    }.freeze

    # === Options:
    # * <tt>:
    def initialize(to, from, weight, options = {})
      @to = to
      @from = from
      @weight = weight
      @options = DEFAULTS.merge(options)
    end

    def build
      super do |builder|
        builder.tag!('Option', '1')
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
        builder.tag!('ServiceType', self.service)
        builder.tag!('ImageType', 'TIF')
      end
    end
  end
end
