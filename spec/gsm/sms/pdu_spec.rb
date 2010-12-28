# vim:ts=2:sw=2:et:
require 'spec/spec_helper'

module GSM
  module SMS

    # Examples from http://www.dreamfabric.com/sms/

    describe SubmitPDU do
      it "should convert to octets" do
        pdu = SubmitPDU.new :recipient_number => "+46708251358",
                            :user_data => "E8329BFD4697D9EC37".hex_to_bin,
                            :user_data_length => 10
        pdu.octets.bin_to_hex.should ==
          "0001000B916407281553F80000AA0AE8329BFD4697D9EC37"
      end
    end

    describe DeliverPDU do
      it "should convert to octets" do
        pdu = DeliverPDU.new :smsc_number => "+27381000015",
                             :sender_number => "+27838890001",
                             :time => Time.gm( 1999, 3, 29, 15, 16, 59 ),
                             :user_data => "E8329BFD4697D9EC37".hex_to_bin,
                             :user_data_length => 10
        pdu.octets.bin_to_hex.should ==
          "07917283010010F5040B917238880900F10000993092516195000AE8329BFD4697D9EC37"
      end

      it "should convert mobile number to octets" do
        pdu = DeliverPDU.new
        pdu.send( :mobile_number_octets, "40745445954" ).bin_to_hex.
          should == "0B910447455459F4"
      end
    end

  end
end

