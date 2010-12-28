module GSM
  class WSPDatagram
    attr_accessor :tid, :pdu_type, :wsp_headers, :body
    
    def initialize( tid, pdu_type, wsp_headers, body )
      @tid = tid
      @pdu_type = pdu_type
      @wsp_headers = wsp_headers
      @body = body
    end

    def octets
      tid.chr + pdu_type.chr +
        wsp_headers.length.chr +
        wsp_headers +
        body
    end
  end
end

