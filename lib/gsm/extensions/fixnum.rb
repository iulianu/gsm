# vim:ts=2:sw=2:et:

module GSM
  module Extensions
    module Fixnum
      def short_to_bin
        sprintf("%04X", self)[-4..-1].hex_to_bin
      end
    end
  end
end


