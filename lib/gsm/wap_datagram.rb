# vim:ts=2:sw=2:et:

module GSM

  class WAPDatagram
    def initialize( opts = {} )
      @opts = opts
    end

    def recipient;        @opts[:recipient]; end
    def source_port;      @opts[:source_port]; end
    def destination_port; @opts[:destination_port]; end
    def data;             @opts[:data]; end

    # Creates an array of SMS UD bytes
    # with the bytes of this datagram as payload
    def to_sms_data
      raise "No destination port specified" unless @opts[:destination_port]
      raise "No source port specified" unless @opts[:source_port]
      raise "No data given" unless @opts[:data]

      wdp_udh = GSM::SMS::WDPHeaderUDH.new( @opts[:source_port], @opts[:destination_port] )
      data = @opts[:data]
      if wdp_udh.octets.size + data.size > 139
        # Concatenation needed
        # TODO this logic is duplicated in TextMessage as well
        ptr = 0
        uds = []
        concat_ref = 0xA0
        while ptr < data.size
          ud = GSM::SMS::UserData.new :udh => [
            GSM::SMS::ConcatenateUDH.new( concat_ref, 2, 1 ),
            wdp_udh
          ]
          available_octets = 140 - ud.udh_octets.size
          payload_octets = data[ptr..(ptr + available_octets - 1)]
          ud.set_payload( payload_octets, payload_octets.size, :octets )
          ptr += payload_octets.size
          ud.recipient = @opts[:recipient]
          uds << ud
        end
        num_parts = uds.size
        # Now rewrite the num_parts and current_part fields
        # in the Concatenate UDH element
        uds.each_with_index do |ud, i|
          ud.udh[0].num_parts    = num_parts
          ud.udh[0].current_part = i + 1
        end

        return uds

      else
        ud = GSM::SMS::UserData.new :udh => [wdp_udh]
        ud.set_payload( data, data.size, :octets )
        ud.recipient = @opts[:recipient]
        return [ud]
      end
    end
  end

end
