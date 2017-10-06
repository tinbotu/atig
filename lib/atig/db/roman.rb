# -*- mode:ruby; coding:utf-8 -*-

module Atig
  module Db
    class Roman
      Seq = %w[
	  a   i   u   e   o  ka  ki  ku  ke  ko  sa shi  su  se  so
	 ta chi tsu  te  to  na  ni  nu  ne  no  ha  hi  fu  he  ho
	 ma  mi  mu  me  mo  ya      yu      yo  ra  ri  ru  re  ro
	 wa              wo   n
	 ga  gi  gu  ge  go  za  ji  zu  ze  zo  da          de  do
	 ba  bi  bu  be  bo  pa  pi  pu  pe  po
	 ja      ju      jo
      ].freeze

      def make(n)
        ret = []
        begin
          n, r = n.divmod(Seq.size)
          ret << Seq[r]
        end while n > 0
        ret.reverse.join
      end
    end
  end
end
