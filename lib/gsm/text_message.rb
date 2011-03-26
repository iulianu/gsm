# vim:ts=2:sw=2:et:

module GSM
  
  class TextMessage
    attr_accessor :body, :recipient

    def initialize( recipient, body, opts = {} )
      @recipient = recipient
      @body = body
      @charset = :latin1
    end

    def to_sms_data
      payload = body_octets
      uds = []
      if payload.size > 139
        # Concatenation needed
        # TODO this logic is duplicated in WAPDatagram as well
        ptr = 0
        concat_ref = 0xA0
        while ptr < payload.size
          ud = GSM::SMS::UserData.new :udh => [
            GSM::SMS::ConcatenateUDH.new( concat_ref, 2, 1 ),
          ]
          available_octets = 140 - ud.udh_octets.size
          payload_octets = payload[ptr..(ptr + available_octets - 1)]
          ud.set_payload( payload_octets, payload_octets.size, :octets )
          ptr += payload_octets.size
          uds << ud
        end
        num_parts = uds.size
        # Now rewrite the num_parts and current_part fields
        # in the Concatenate UDH element
        uds.each_with_index do |ud, i|
          ud.udh[0].num_parts    = num_parts
          ud.udh[0].current_part = i + 1
        end

      else
        ud = GSM::SMS::UserData.new
        ud.set_payload(payload, payload.size, :octets)
        uds << ud
      end

      uds.each do |ud|
        ud.recipient = self.recipient
      end

      uds
    end

    def body_octets
      # TODO take into account the @charset
      @body
    end

  end

end
