# vim:ts=2:sw=2:et:

module GSM
  module SMS

    class ConcatenateUDH
      attr_accessor :refno, :num_parts, :current_part

      def initialize( refno, num_parts, current_part )
        @refno = refno
        @num_parts = num_parts
        @current_part = current_part
      end

      def octets
        "\x00\x03" + @refno.chr + @num_parts.chr + @current_part.chr
      end
    end

    class WDPHeaderUDH
      attr_accessor :source_port, :destination_port

      def initialize( source_port, destination_port )
        @source_port = source_port
        @destination_port = destination_port
      end

      def octets
        "\x05\x04" + @destination_port.short_to_bin + @source_port.short_to_bin
      end
    end

  end
end

