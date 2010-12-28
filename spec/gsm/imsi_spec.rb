# vim:ts=2:sw=2:et:
require 'spec/spec_helper'

module GSM
  describe IMSI do

    it "should calculate netwpin" do
      IMSI.new("262073991646314").netwpin.should == "2926709319463641"
      IMSI.new("226019053007568").netwpin.should == "2962100935005786"
    end

  end
end
