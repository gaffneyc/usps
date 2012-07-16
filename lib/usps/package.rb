module USPS

  class Package < Struct.new(:id, :service, :origin_zip, :destination_zip, :pounds, :ounces, :container, :size,
                             :width, :length, :height, :girth, :value, :amount_to_collect, :first_class_mail_type)

    @@required_properties = %w{id service origin_zip destination_zip pounds ounces container size}

    def initialize(args = {})
      args.each_pair { |k, v| send("#{k}=", v) }
      yield self if block_given?

      @@required_properties.each do |prop|
        raise ArgumentError, "#{prop} is required" unless send(prop)
      end
    end
  end

end
