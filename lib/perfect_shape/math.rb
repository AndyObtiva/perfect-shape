module PerfectShape
  module Math
    class << self
      # ported from fdlibm: https://www.netlib.org/fdlibm/e_remainder.c
      def ieee754_remainder(x, p)
        # TODO handle exception scenarios
        x = x.to_f
        p = p.to_f
        division = BigDecimal(x) / BigDecimal(p)
        rounded_division_low = division.floor
        rounded_division_high = division.ceil
        rounded_division_half = rounded_division_low + 0.5
        rounded_division = nil
        if division == rounded_division_half
          rounded_division = rounded_division_low.even? ? rounded_division_low : rounded_division_high
        else
          rounded_division.round
        end
        (BigDecimal(x) - (BigDecimal(rounded_division) * BigDecimal(p)))
      end
      alias ieee_remainder ieee754_remainder
    end
  end
end
