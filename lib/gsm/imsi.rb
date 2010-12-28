# vim:ts=2:sw=2:et:
module GSM
  class IMSI
  
    def initialize(code)
      @code = code
    end

    def netwpin
      pin = @code.dup
      pin += "F" while pin.size < 15
      pin = "9" + pin if pin.size.odd? # parity
      0.upto(pin.size / 2 - 1) do |i|
        pin[2*i..2*i+1] = pin[2*i..2*i+1].reverse
      end
      pin
    end

  end
end
