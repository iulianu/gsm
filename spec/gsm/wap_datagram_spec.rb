# vim:ts=2:sw=2:et:
require 'spec/spec_helper'

module GSM
  describe WAPDatagram do
    it "should transform into single SMS UserData" do
      dgram = WAPDatagram.new :source_port => 2948,
                              :destination_port => 2948,
                              :data => "Once upon a midnight dreary, while I pondered, weak and weary, Over many a quaint and curious volume of forgotten lore"
      uds = dgram.to_sms_data
      uds.size.should == 1
      uds.first.octets.should ==
        "\x06\x05\x04\x0B\x84\x0B\x84Once upon a midnight dreary, while I pondered, weak and weary, Over many a quaint and curious volume of forgotten lore"
    end

    it "should transform into concatenated SMS UserData's" do
      dgram = WAPDatagram.new :source_port => 2948,
                              :destination_port => 2948,
                              :data => "Once upon a midnight dreary, while I pondered, weak and weary, Over many a quaint and curious volume of forgotten lore, While I nodded, nearly napping, suddenly there came a tapping"
      uds = dgram.to_sms_data
      uds.size.should == 2

      uds[0].octets.should ==
        "\x0B\x00\x03\xA0\x02\x01\x05\x04\x0B\x84\x0B\x84Once upon a midnight dreary, while I pondered, weak and weary, Over many a quaint and curious volume of forgotten lore, While I "

      uds[1].octets.should ==
        "\x0B\x00\x03\xA0\x02\x02\x05\x04\x0B\x84\x0B\x84nodded, nearly napping, suddenly there came a tapping"
    end
  end
end

