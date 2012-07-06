module USPS
  class Postage < Struct.new(:rate, :mail_service, :class_id)
  end
end
