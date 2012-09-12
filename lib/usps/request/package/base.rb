module USPS::Request::Package
  class Base
    attr_accessor :id
    attr_accessor :pounds, :ounces
    attr_accessor :container
    attr_accessor :size
    attr_accessor :width, :length, :height, :girth

    @@required = [:id, :pounds, :ounces, :size]

    def initialize(fields)
      fields.each { |name, value| send("#{name}=", value) }

      yield self if block_given?

      if fields[:size] == 'LARGE'
        [:container, :width, :length, :height].each do |field|
          error "#{field} is required when Size=LARGE" unless fields[field]
        end
      end

      @@required.each do |field|
        error "#{field} is required" unless fields[field]
      end
    end

    protected

    def error(message)
      raise ArgumentError.new message
    end
  end
end
