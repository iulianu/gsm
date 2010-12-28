# vim:ts=2:sw=2:et:

require 'rubygems'
gem 'ruby-hmac'
require 'hmac-sha1'
require 'gsm/wap_datagram'

module GSM
  
  class OMASettingsDocument
    attr_accessor :xml, :recipient, :sec, :pin

    # * sec is :userpin or :netwpin
    # * pin is a string containing
    #     - the literal PIN in case sec is :userpin
    #     - the hex representation of the network pin if sec is :netwpin
    def initialize( recipient, xml, opts = {} )
      @recipient = recipient
      @xml = xml
      @sec = opts[:sec]
      @pin = opts[:pin]
    end

    def oma_wsp_headers
      "\xB6" + # ContentType= S-Push.req::Push. This is 0x36 with "high-bit set"
          ota_sec_wsp_headers
    end

    # Returns WSP headers needed for OTA documents protected by
    # a security method
    def ota_sec_wsp_headers
      sec_byte = case @sec
      when :netwpin     : "\x80"
      when :userpin     : "\x81"
      when :usernetwpin : "\x82"
      when :userpinmac  : "\x83"
      else
        raise "Unknown sec method #{@sec}"
      end

      mac_hex = ota_hmac.bin_to_hex # Yes, converted to hex!

      "\x91"   + # SEC
        sec_byte +
        "\x92"   + # MAC value ID
        mac_hex +
        "\x00"     # End-of-MAC tag
    end

    # Calculates the HMAC hash for the given OTA document
    # The HMAC is returned in binary, it should be a 20-byte
    # long string.
    def ota_hmac
      OMASettingsDocument.ota_hmac(@sec, @pin, body_octets)
    end

    def self.ota_hmac(sec, pin, body)
      key_bin = case sec
      when :userpin    : pin
      when :netwpin    : pin.hex_to_bin
      end
      HMAC::SHA1.digest( key_bin, body )
    end

    def body_octets
      xml_to_wbxml( @xml )
    end

    def octets
       wsp_headers = oma_wsp_headers
       wsp_pdu( 0x01, # Bogus TID
                0x06, # PDU type PUSH
                "\x1F" + # ValueLengthQuote
                          wsp_headers.length.chr +
                          wsp_headers,
                body_octets )
    end

    def to_wap_datagram
      MM4R::WapDatagram.new :recipient => @recipient,
                            :source_port => 9200,
                            :destination_port => 2948,
                            :data => octets
    end

  end

end
