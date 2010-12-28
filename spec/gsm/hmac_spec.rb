# vim:ts=2:sw=2:et:
require 'spec/spec_helper'

module GSM
  describe OMASettingsDocument do
    it "should generate HMAC based on userpin" do
      # http://discussion.forum.nokia.com/forum/showthread.php?p=404352
      key = "1234"
      body = "c54601c60001550187360603773500018722060342726f7773696e675f4750525300018707060353757065726d616e2053796e634d4c000187340603687474703a2f2f6d6574726f706f6c69732e636f6d3a383038302f736572766963652f73796e630001c65901873a06032e2f636f6e7461637473000187070603436f6e74616374732044420001872e0603746578742f782d7663617264000101c65901873a06032e2f63616c656e64617200018707060343616c656e6461722044420001872e0603746578742f782d7663616c656e646172000101c65701873106036e616d653400018732060370617373776f7264340001010101".hex_to_bin
      hmac = OMASettingsDocument.ota_hmac :userpin, key, body
      hmac.bin_to_hex.downcase.should == "49a4f8bac2a1987292a427faf7ad026c316f361f"

      # http://www.codeproject.com/KB/recipes/WBXML.aspx?display=PrintAll&fid=312290&df=90&mpp=25&noise=3&sort=Position&view=Quick&fr=26
      key = "1234"
      body = "030B6A054E4150310045C65101871506033137302E3138372E35312E3400018707060342616E6B4D61696E50726F78790001871C0603687474703A2F2F7777772E62616E6B2E636F6D2F7374617274706167652E776D6C0001C65901871A06037078757365726E616D650001871B06037078757365727061737377000101C65201872F060350524F585920310001871706037777772E62616E6B2E636F6D2F0001872006033137302E3138372E35312E330001872106850187220603494E5445524E45540001872206830001C6530187230603393230330001010101C65501871106830001871006AA01870706034D5920495350204353440001870806032B333538303831323430303200018709068701870A0603414E414C4F475F4D4F44454D0001C65A01870C069A01870D06037777776D6D6D757365720001870E06037777776D6D6D736563726574000101C65401871206033232380001871306033030310001010101".hex_to_bin
      hmac = OMASettingsDocument.ota_hmac :userpin, key, body
      hmac.bin_to_hex.should == "97D6BB059154A6ACD8B48BFD11EAC9CB2F85B1DF"
    end

    it "should generate HMAC based on netwpin" do
      # http://www.codeproject.com/KB/recipes/WBXML.aspx?display=PrintAll&fid=312290&df=90&mpp=25&noise=3&sort=Position&view=Quick&fr=26
      netwpin = "2943214365871932" # From IMSI 234123456789123
      body = "030B6A054E4150310045C65101871506033137302E3138372E35312E3400018707060342616E6B4D61696E50726F78790001871C0603687474703A2F2F7777772E62616E6B2E636F6D2F7374617274706167652E776D6C0001C65901871A06037078757365726E616D650001871B06037078757365727061737377000101C65201872F060350524F585920310001871706037777772E62616E6B2E636F6D2F0001872006033137302E3138372E35312E330001872106850187220603494E5445524E45540001872206830001C6530187230603393230330001010101C65501871106830001871006AA01870706034D5920495350204353440001870806032B333538303831323430303200018709068701870A0603414E414C4F475F4D4F44454D0001C65A01870C069A01870D06037777776D6D6D757365720001870E06037777776D6D6D736563726574000101C65401871206033232380001871306033030310001010101".hex_to_bin
      hmac = OMASettingsDocument.ota_hmac :netwpin, netwpin, body
      hmac.bin_to_hex.should == "7957A17AE4321682A1DF8A5BAABB6BE62B9B4DA7"
    end

  end
end
