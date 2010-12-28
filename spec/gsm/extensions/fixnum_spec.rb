# vim:ts=2:sw=2:et:
require 'spec_helper.rb'

describe Fixnum do

  it "should convert to binary" do
    9200.short_to_bin.should == "\x23\xF0"
  end

end
