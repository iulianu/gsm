# vim:ts=2:sw=2:et:
require 'spec/spec_helper'

module GSM
  module SMS

    describe UserData do

      it "should convert simple UD to octets" do
        ud = UserData.new
        ud.set_payload "E8329BFD4697D9EC37".hex_to_bin, 10
        ud.octets.bin_to_hex.should == "E8329BFD4697D9EC37"
      end

      it "should convert UD with concatenation header to octets" do
        txt1 = "Once upon a midnight dreary, while I pondered, weak and weary, Over many a quaint and curious volume of forgotten lore, While I nodded"
        ud1 = UserData.new :udh => [ ConcatenateUDH.new(0xA4, 2, 1) ]
        ud1.set_payload txt1, txt1.size, :octets
        ud1.octets[0..5].should == "\x05\x00\x03\xA4\x02\x01"
      end

    end

  end
end

