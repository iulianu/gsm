# vim:ts=2:sw=2:et:
require 'spec/spec_helper'

module GSM
  describe MSISDN do
    it "should convert number to international format" do
      MSISDN.to_international_format("+40739123433").should == "40739123433"
    end
  end
end

