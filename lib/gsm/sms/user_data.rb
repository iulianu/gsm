# vim:ts=2:sw=2:et:

module GSM
  module SMS
    class UserData
      attr_reader :udh, :payload_octets, :payload_length, :alphabet
      attr_accessor :recipient

      def initialize( opts={} )
        @udh = opts[:udh]
      end

      def set_payload( payload_octets, payload_length, alphabet = :default )
        raise RuntimeError.new("Payload too big") if udh_octets.size + payload_octets.size > 140
0
        @payload_octets = payload_octets
        @payload_length = payload_length
        @alphabet = alphabet
      end

      def octets
        udh_octets + payload_octets
      end

      def udh_octets
        return "" unless @udh
        udh_headers_octets = @udh.inject("") {|sum, header_element| sum + header_element.octets}
        udh_headers_octets.size.chr +
          udh_headers_octets
      end

    end
  end
end

