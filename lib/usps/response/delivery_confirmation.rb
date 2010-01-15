module USPS::Response
  class DeliveryConfirmation < Base
    attr_reader :label, :confirmation, :address, :postnet

    alias :confirmation_number :confirmation

    def initialize(xml)
      @label = xml.search('DeliveryConfirmationLabel').text
      @confirmation = xml.search('DeliveryConfirmationNumber').text
      @postnet = xml.search('Postnet').text

      @address = USPS::Address.new(
        :name     => xml.search('ToName').text,
        :company  => xml.search('ToFirm').text,
        :address  => xml.search('ToAddress2').text,
        :address2 => xml.search('ToAddress1').text,
        :city     => xml.search('ToCity').text,
        :state    => xml.search('ToState').text,
        :zip5     => xml.search('ToZip5').text,
        :zip4     => xml.search('ToZip4').text
      )
    end
  end
end
