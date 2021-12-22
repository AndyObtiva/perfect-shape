# Copyright (c) 2021 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'perfect_shape/shape'
require 'perfect_shape/multi_point'

module PerfectShape
  # Mostly ported from java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/QuadCurve2D.html
  class CubicBezierCurve < Shape
    class << self
      # Calculates the number of times the cubic bézier curve from (x1,y1) to (x2,y2)
      # crosses the ray extending to the right from (x,y).
      # If the point lies on a part of the curve,
      # then no crossings are counted for that intersection.
      # the level parameter should be 0 at the top-level call and will count
      # up for each recursion level to prevent infinite recursion
      # +1 is added for each crossing where the Y coordinate is increasing
      # -1 is added for each crossing where the Y coordinate is decreasing
      def point_crossings(x1, y1, xc1, yc1, xc2, yc2, x2, y2, px, py, level = 0)
        return 0 if (py <  y1 && py <  yc1 && py <  yc2 && py <  y2)
        return 0 if (py >= y1 && py >= yc1 && py >= yc2 && py >= y2)
        # Note y1 could equal yc1...
        return 0 if (px >= x1 && px >= xc1 && px >= xc2 && px >= x2)
        if (px <  x1 && px <  xc1 && px <  xc2 && px <  x2)
          if (py >= y1)
            return 1 if (py < y2)
          else
            # py < y1
            return -1 if (py >= y2)
          end
          # py outside of y12 range, and/or y1==yc1
          return 0
        end
        # double precision only has 52 bits of mantissa
        return PerfectShape::Line.point_crossings(x1, y1, x2, y2, px, py) if (level > 52)
        xmid = BigDecimal((xc1 + xc2).to_s) / 2;
        ymid = BigDecimal((yc1 + yc2).to_s) / 2;
        xc1 = BigDecimal((x1 + xc1).to_s) / 2;
        yc1 = BigDecimal((y1 + yc1).to_s) / 2;
        xc2 = BigDecimal((xc2 + x2).to_s) / 2;
        yc2 = BigDecimal((yc2 + y2).to_s) / 2;
        xc1m = BigDecimal((xc1 + xmid).to_s) / 2;
        yc1m = BigDecimal((yc1 + ymid).to_s) / 2;
        xmc1 = BigDecimal((xmid + xc2).to_s) / 2;
        ymc1 = BigDecimal((ymid + yc2).to_s) / 2;
        xmid = BigDecimal((xc1m + xmc1).to_s) / 2;
        ymid = BigDecimal((yc1m + ymc1).to_s) / 2;
        # [xy]mid are NaN if any of [xy]c0m or [xy]mc1 are NaN
        # [xy]c0m or [xy]mc1 are NaN if any of [xy][c][01] are NaN
        # These values are also NaN if opposing infinities are added
        return 0 if (xmid.nan? || ymid.nan?)
        point_crossings(x1, y1, xc1, yc1, xc1m, yc1m, xmid, ymid, px, py, level+1) +
          point_crossings(xmid, ymid, xmc1, ymc1, xc2, yc2, x2, y2, px, py, level+1)
      end
    end
    
    include MultiPoint
    include Equalizer.new(:points)
    
    # Checks if cubic bézier curve contains point (two-number Array or x, y args)
    #
    # @param x The X coordinate of the point to test.
    # @param y The Y coordinate of the point to test.
    #
    # @return {@code true} if the point lies within the bound of
    # the cubic bézier curve, {@code false} if the point lies outside of the
    # cubic bézier curve's bounds.
    def contain?(x_or_point, y = nil)
      x, y = normalize_point(x_or_point, y)
      return unless x && y
      
      # Either x or y was infinite or NaN.
      # A NaN always produces a negative response to any test
      # and Infinity values cannot be "inside" any path so
      # they should return false as well.
      return false if (!(x * 0.0 + y * 0.0 == 0.0))
      # We count the "Y" crossings to determine if the point is
      # inside the curve bounded by its closing line.
      x1 = points[0][0]
      y1 = points[0][1]
      x2 = points[3][0]
      y2 = points[3][1]
      line = PerfectShape::Line.new(points: [[x1, y1], [x2, y2]])
      crossings = line.point_crossings(x, y) + point_crossings(x, y);
      (crossings & 1) == 1
    end
    
    # Calculates the number of times the cubic bézier curve
    # crosses the ray extending to the right from (x,y).
    # If the point lies on a part of the curve,
    # then no crossings are counted for that intersection.
    # the level parameter should be 0 at the top-level call and will count
    # up for each recursion level to prevent infinite recursion
    # +1 is added for each crossing where the Y coordinate is increasing
    # -1 is added for each crossing where the Y coordinate is decreasing
    def point_crossings(x_or_point, y = nil, level = 0)
      x, y = normalize_point(x_or_point, y)
      return unless x && y
      CubicBezierCurve.point_crossings(points[0][0], points[0][1], points[1][0], points[1][1], points[2][0], points[2][1], points[3][0], points[3][1], x, y, level)
    end
  end
end
