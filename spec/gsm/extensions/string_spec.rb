# vim:ts=2:sw=2:et:

describe String do

  it "should convert hex to binary octets" do
    a = "006162637EFF"
    a.hex_to_bin.should == "\000abc\x7E\xFF"
  end

  it "should convert binary octets to hex" do
    a = "\000abc\x7E\xFF"
    a.bin_to_hex.should == "006162637EFF"
  end

  describe "semi octet encoding as per GSM 03.40 section 9.1.2.3" do
    it "should encode even number of nibbles" do
      "1234".semi_octet_encode.should == "2143"
    end

    it "should encode odd number of nibbles" do
      "12345".semi_octet_encode.should == "2143F5"
    end
  end

end
