# vim:ts=2:sw=2:et:

module GSM
  module SMS

    # :alphabet can be:
    #   - :default for 7-bit character data in the GSM alphabet
    #   - :octets  for 8-bit data
    #   - :ucs2    for 16-bit character data
    class PDU
      def initialize( opts = {} )
        @opts = { :alphabet => :default,
                  :has_udh  => false }.merge( opts )
      end

      protected

      def smsc_info_octets
        if @opts[:smsc_number]
          address_octets( @opts[:smsc_number] )
        else
          ""
        end
      end
        
      # The TP-PID octet
      def pid; "\x00"; end
      
      # The TP-DCS octet
      def dcs
        case @opts[:alphabet]
        when :default : "\x00";
        when :octets  : "\x04";
        when :ucs2    : "\x08";
        else
          raise SMS_PDU_Exception.new("Invalid alphabet #{@opts[:alphabet]}")
        end
      end
      # Service Centre Time Stamp
      def scts
        (
          @opts[:time].strftime("%y%m%d%H%M%S") +
            sprintf( "%02d", (@opts[:time].gmt_offset / 60 / 15) )
        ).semi_octet_encode.hex_to_bin
      end

      def mobile_number_octets(mobile_number)
        digits = GSM::MSISDN.new( mobile_number ).number
        len = digits.size
        len.chr +
          address_octets( mobile_number )
      end

      def address_octets(number)
        digits = GSM::MSISDN.new( number ).number
        "\x91" + # Type-of-address = International format
          digits.semi_octet_encode.hex_to_bin
      end

    end

    class DeliverPDU < PDU
      def initialize( opts={} )
        super( {:more_to_send => false}.
          merge(opts) )
      end

      # The binary packed form of this SMS DELIVER PDU
      def octets
        smsc_info_octets.size.chr +
          smsc_info_octets +
          sms_deliver_octets
      end

      def sms_deliver_octets
        sms_deliver_first_octet +
          mobile_number_octets(@opts[:sender_number]) +
          pid +
          dcs +
          scts +
          @opts[:user_data_length].chr +
          @opts[:user_data]
      end

      private

      # First octet of the SMS-DELIVER PDU
      def sms_deliver_first_octet
        octet = 0
        octet |= 0x04 unless @opts[:more_to_send]
        octet |= 0x80 if @opts[:has_udh]
        octet.chr
      end
    end

    class SubmitPDU < PDU
      def initialize( opts={} )
        super( opts )
      end

      # The binary packed form of this SMS SUBMIT PDU
      def octets
        smsc_info_octets.size.chr +
          smsc_info_octets +
          sms_submit_octets
      end

      def sms_submit_octets
        sms_submit_first_octet +
          message_reference_octet +
          mobile_number_octets(@opts[:recipient_number]) +
          pid +
          dcs +
          validity_period_octet +
          @opts[:user_data_length].chr +
          @opts[:user_data]
      end

      private

      # First octet of the SMS-SUBMIT PDU
      def sms_submit_first_octet
        octet = 1
        octet |= 0x80 if @opts[:has_udh]
        octet.chr
      end

      def message_reference_octet
        "\x00"
      end

      def validity_period_octet
        "\xAA"
      end
    end
  end
end

