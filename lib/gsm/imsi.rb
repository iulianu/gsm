# vim:ts=2:sw=2:et:

module GSM
  class IMSI
def imsi_to_international_format( imsi )
  imsi.sub /^\+/, ''
end

  end
end

