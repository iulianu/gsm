# vim:ts=2:sw=2:et:

module GSM
  class MSISDN
    def initialize(number = nil)
      unless number.nil?
        @number = MSISDN.to_international_format(number)
      end
    end

    def to_s
      "#<#{self.class}: #{@number}>"
    end

    private

      def self.to_international_format(number)
        number.sub /^\+/, ''
      end
  end
end

