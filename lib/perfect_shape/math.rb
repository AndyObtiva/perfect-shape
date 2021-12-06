module PerfectShape
  # Perfect Shape Math utility methods
  # Also includes standard Ruby ::Math utility methods
  module Math
    class << self
      # converts angle from radians to degrees
      def radians_to_degrees(radians)
        (180/Math::PI)*radians
      end

      # Computes the remainder operation on two arguments as prescribed by the IEEE 754 standard.
      # Algorithm: x – (round(x/y)*y).
      # The `round` part rounds to the nearest even number when it is a halfway between n & y (integer + 0.5 number)
      # The remainder value is mathematically equal to x - y × n, where n is the mathematical integer closest to the exact mathematical value of the quotient x/y, and if two mathematical integers are equally close to x/y, then n is the integer that is even. If the remainder is zero, its sign is the same as the sign of the first argument. Special cases:
      # If either argument is NaN, or the first argument is infinite, or the second argument is positive zero or negative zero, then the result is NaN.
      # If the first argument is finite and the second argument is infinite, then the result is the same as the first argument.
      # Parameters:
      # x - the dividend.
      # y - the divisor.
      # Returns:
      # the remainder when x is divided by y.
      def ieee754_remainder(x, y)
        x = BigDecimal(x.to_s)
        y = BigDecimal(y.to_s)
        return BigDecimal::NAN if x.nan? || y.nan? || x.infinite? || y.zero?
        return x if x.finite? && y.infinite?
        division = x / y
        rounded_division_low = BigDecimal(division.floor)
        rounded_division_high = BigDecimal(division.ceil)
        rounded_division_half = rounded_division_low + 0.5
        rounded_division = if division == rounded_division_half
          rounded_division_low.to_i.even? ? rounded_division_low : rounded_division_high
        else
          BigDecimal(division.round)
        end
        (x - (rounded_division * y))
      end
      alias ieee_remainder ieee754_remainder
      
      def respond_to?(method_name, include_private = false)
        super || ::Math.respond_to?(method_name, include_private)
      end
      
      def method_missing(method_name, *args, **kwargs, &block)
        if ::Math.respond_to?(method_name, true)
          ::Math.send(method_name, *args, **kwargs, &block)
        else
          super
        end
      end
      
      def const_missing(constant)
        ::Math::const_get(constant)
      end
    end
  end
end
