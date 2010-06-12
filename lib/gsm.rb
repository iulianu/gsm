require 'gsm/extensions/string'
require 'gsm/extensions/fixnum'

class String
  include GSM::Extensions::String
end

class Fixnum
  include GSM::Extensions::Fixnum
end

require 'gsm/imsi'
require 'gsm/msisdn'
require 'gsm/sms'
require 'gsm/text_message'


