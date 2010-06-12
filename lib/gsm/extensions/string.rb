# vim:ts=2:sw=2:et:
module GSM
  module Extensions
    module String

      # Returns a hex string representing the semi-octet
      # encoding of the input decimal string
      def semi_octet_encode
        str = self
        str += "F" if str.size % 2 == 1
        0.upto(str.size / 2 - 1) do |i|
          str[2*i..2*i+1] = str[2*i..2*i+1].reverse
        end
        str
      end

      def bin_to_hex
        hexstr = ""
        each_byte do |b|
          hexstr += sprintf("%02x", b)
        end
        hexstr.upcase
      end

      def hex_to_bin
        split(/(\w\w)/).inject("") {|bin, d| bin + (d.size > 0 ? d.to_i(16).chr : "") }
      end
    end
  end
end

