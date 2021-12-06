module PerfectShape
  module Math
    class << self
      # Computes the remainder operation on two arguments as prescribed by the IEEE 754 standard. The remainder value is mathematically equal to x - p × n, where n is the mathematical integer closest to the exact mathematical value of the quotient x/p, and if two mathematical integers are equally close to x/p, then n is the integer that is even. If the remainder is zero, its sign is the same as the sign of the first argument. Special cases:
      # If either argument is NaN, or the first argument is infinite, or the second argument is positive zero or negative zero, then the result is NaN.
      # If the first argument is finite and the second argument is infinite, then the result is the same as the first argument.
      # Parameters:
      # x - the dividend.
      # p - the divisor.
      # Returns:
      # the remainder when x is divided by p.
      def ieee754_remainder(x, p)
        # TODO handle exception scenarios:
        # - BigDecimal::NAN if x/p are NAN, x is Infinity, or p as +-0.0
        # - if x is finite and p is Infinity, then result is x
        x = BigDecimal(x.to_s)
        p = BigDecimal(p.to_s)
        division = x / p
        rounded_division_low = BigDecimal(division.floor)
        rounded_division_high = BigDecimal(division.ceil)
        rounded_division_half = rounded_division_low + 0.5
        rounded_division = if division == rounded_division_half
          rounded_division_low.to_i.even? ? rounded_division_low : rounded_division_high
        else
          BigDecimal(rounded_division.round)
        end
        (x - (rounded_division * p))
      end
      alias ieee_remainder ieee754_remainder
    end
  end
end
