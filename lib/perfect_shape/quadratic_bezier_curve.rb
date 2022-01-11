# Copyright (c) 2021-2022 Andy Maleh
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
  class QuadraticBezierCurve < Shape
    class << self
      # Calculates the number of times the quadratic bézier curve from (x1,y1) to (x2,y2)
      # crosses the ray extending to the right from (x,y).
      # If the point lies on a part of the curve,
      # then no crossings are counted for that intersection.
      # the level parameter should be 0 at the top-level call and will count
      # up for each recursion level to prevent infinite recursion
      # +1 is added for each crossing where the Y coordinate is increasing
      # -1 is added for each crossing where the Y coordinate is decreasing
      def point_crossings(x1, y1, xc, yc, x2, y2, px, py, level = 0)
        return 0 if (py <  y1 && py <  yc && py <  y2)
        return 0 if (py >= y1 && py >= yc && py >= y2)
        # Note y1 could equal y2...
        return 0 if (px >= x1 && px >= xc && px >= x2)
        if (px <  x1 && px <  xc && px <  x2)
          if (py >= y1)
            return 1 if (py < y2)
          else
            # py < y1
            return -1 if (py >= y2)
          end
          # py outside of y11 range, and/or y1==y2
          return 0
        end
        # double precision only has 52 bits of mantissa
        return PerfectShape::Line.point_crossings(x1, y1, x2, y2, px, py) if (level > 52)
        x1c = BigDecimal((x1 + xc).to_s) / 2
        y1c = BigDecimal((y1 + yc).to_s) / 2
        xc1 = BigDecimal((xc + x2).to_s) / 2
        yc1 = BigDecimal((yc + y2).to_s) / 2
        xc = BigDecimal((x1c + xc1).to_s) / 2
        yc = BigDecimal((y1c + yc1).to_s) / 2
        # [xy]c are NaN if any of [xy]0c or [xy]c1 are NaN
        # [xy]0c or [xy]c1 are NaN if any of [xy][0c1] are NaN
        # These values are also NaN if opposing infinities are added
        return 0 if (xc.nan? || yc.nan?)
        point_crossings(x1, y1, x1c, y1c, xc, yc, px, py, level+1) +
          point_crossings(xc, yc, xc1, yc1, x2, y2, px, py, level+1);
      end
    end
    
    include MultiPoint
    include Equalizer.new(:points)
    
    OUTLINE_MINIMUM_DISTANCE_THRESHOLD = BigDecimal('0.001')
    
    # Checks if quadratic bézier curve contains point (two-number Array or x, y args)
    #
    # @param x The X coordinate of the point to test.
    # @param y The Y coordinate of the point to test.
    #
    # @return {@code true} if the point lies within the bound of
    # the quadratic bézier curve, {@code false} if the point lies outside of the
    # quadratic bézier curve's bounds.
    def contain?(x_or_point, y = nil, outline: false, distance_tolerance: 0)
      x, y = normalize_point(x_or_point, y)
      return unless x && y

      x1 = points[0][0]
      y1 = points[0][1]
      xc = points[1][0]
      yc = points[1][1]
      x2 = points[2][0]
      y2 = points[2][1]
      
      if outline
        distance_tolerance = BigDecimal(distance_tolerance.to_s)
        minimum_distance_threshold = OUTLINE_MINIMUM_DISTANCE_THRESHOLD + distance_tolerance
        point_distance(x, y, minimum_distance_threshold: minimum_distance_threshold) < minimum_distance_threshold
      else
        # We have a convex shape bounded by quad curve Pc(t)
        # and ine Pl(t).
        #
        #     P1 = (x1, y1) - start point of curve
        #     P2 = (x2, y2) - end point of curve
        #     Pc = (xc, yc) - control point
        #
        #     Pq(t) = P1*(1 - t)^2 + 2*Pc*t*(1 - t) + P2*t^2 =
        #           = (P1 - 2*Pc + P2)*t^2 + 2*(Pc - P1)*t + P1
        #     Pl(t) = P1*(1 - t) + P2*t
        #     t = [0:1]
        #
        #     P = (x, y) - point of interest
        #
        # Let's look at second derivative of quad curve equation:
        #
        #     Pq''(t) = 2 * (P1 - 2 * Pc + P2) = Pq''
        #     It's constant vector.
        #
        # Let's draw a line through P to be parallel to this
        # vector and find the intersection of the quad curve
        # and the line.
        #
        # Pq(t) is point of intersection if system of equations
        # below has the solution.
        #
        #     L(s) = P + Pq''*s == Pq(t)
        #     Pq''*s + (P - Pq(t)) == 0
        #
        #     | xq''*s + (x - xq(t)) == 0
        #     | yq''*s + (y - yq(t)) == 0
        #
        # This system has the solution if rank of its matrix equals to 1.
        # That is, determinant of the matrix should be zero.
        #
        #     (y - yq(t))*xq'' == (x - xq(t))*yq''
        #
        # Let's solve this equation with 't' variable.
        # Also let kx = x1 - 2*xc + x2
        #          ky = y1 - 2*yc + y2
        #
        #     t0q = (1/2)*((x - x1)*ky - (y - y1)*kx) /
        #                 ((xc - x1)*ky - (yc - y1)*kx)
        #
        # Let's do the same for our line Pl(t):
        #
        #     t0l = ((x - x1)*ky - (y - y1)*kx) /
        #           ((x2 - x1)*ky - (y2 - y1)*kx)
        #
        # It's easy to check that t0q == t0l. This fact means
        # we can compute t0 only one time.
        #
        # In case t0 < 0 or t0 > 1, we have an intersections outside
        # of shape bounds. So, P is definitely out of shape.
        #
        # In case t0 is inside [0:1], we should calculate Pq(t0)
        # and Pl(t0). We have three points for now, and all of them
        # lie on one line. So, we just need to detect, is our point
        # of interest between points of intersections or not.
        #
        # If the denominator in the t0q and t0l equations is
        # zero, then the points must be collinear and so the
        # curve is degenerate and encloses no area.  Thus the
        # result is false.
        kx = x1 - 2 * xc + x2;
        ky = y1 - 2 * yc + y2;
        dx = x - x1;
        dy = y - y1;
        dxl = x2 - x1;
        dyl = y2 - y1;
  
        t0 = (dx * ky - dy * kx) / (dxl * ky - dyl * kx)
        return false if (t0 < 0 || t0 > 1 || t0 != t0)
  
        xb = kx * t0 * t0 + 2 * (xc - x1) * t0 + x1;
        yb = ky * t0 * t0 + 2 * (yc - y1) * t0 + y1;
        xl = dxl * t0 + x1;
        yl = dyl * t0 + y1;
  
        (x >= xb && x < xl) ||
          (x >= xl && x < xb) ||
          (y >= yb && y < yl) ||
          (y >= yl && y < yb)
      end
    end
    
    # Calculates the number of times the quad
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
      QuadraticBezierCurve.point_crossings(points[0][0], points[0][1], points[1][0], points[1][1], points[2][0], points[2][1], x, y, level)
    end
    
    # The center point on the outline of the curve
    # in Array format as pair of (x, y) coordinates
    def curve_center_point
      subdivisions.last.points[0]
    end
    
    # The center point x on the outline of the curve
    def curve_center_x
      subdivisions.last.points[0][0]
    end
    
    # The center point y on the outline of the curve
    def curve_center_y
      subdivisions.last.points[0][1]
    end
    
    # Subdivides QuadraticBezierCurve exactly at its curve center
    # returning 2 QuadraticBezierCurve's as a two-element Array by default
    #
    # Optional `level` parameter specifies the level of recursions to
    # perform to get more subdivisions. The number of resulting
    # subdivisions is 2 to the power of `level` (e.g. 2 subdivisions
    # for level=1, 4 subdivisions for level=2, and 8 subdivisions for level=3)
    def subdivisions(level = 1)
      level -= 1 # consume 1 level
      
      x1 = points[0][0]
      y1 = points[0][1]
      ctrlx = points[1][0]
      ctrly = points[1][1]
      x2 = points[2][0]
      y2 = points[2][1]
      ctrlx1 = BigDecimal((x1 + ctrlx).to_s) / 2
      ctrly1 = BigDecimal((y1 + ctrly).to_s) / 2
      ctrlx2 = BigDecimal((x2 + ctrlx).to_s) / 2
      ctrly2 = BigDecimal((y2 + ctrly).to_s) / 2
      centerx = BigDecimal((ctrlx1 + ctrlx2).to_s) / 2
      centery = BigDecimal((ctrly1 + ctrly2).to_s) / 2
      
      default_subdivisions = [
        QuadraticBezierCurve.new(points: [x1, y1, ctrlx1, ctrly1, centerx, centery]),
        QuadraticBezierCurve.new(points: [centerx, centery, ctrlx2, ctrly2, x2, y2])
      ]
      
      if level == 0
        default_subdivisions
      else
        default_subdivisions.map { |curve| curve.subdivisions(level) }.flatten
      end
    end
    
    def point_distance(x_or_point, y = nil, minimum_distance_threshold: OUTLINE_MINIMUM_DISTANCE_THRESHOLD)
      x, y = normalize_point(x_or_point, y)
      return unless x && y
      
      point = Point.new(x, y)
      current_curve = self
      minimum_distance = point.point_distance(curve_center_point)
      last_minimum_distance = minimum_distance + 1 # start bigger to ensure going through loop once at least
      while minimum_distance >= minimum_distance_threshold && minimum_distance < last_minimum_distance
        curve1, curve2 = current_curve.subdivisions
        distance1 = point.point_distance(curve1.curve_center_point)
        distance2 = point.point_distance(curve2.curve_center_point)
        last_minimum_distance = minimum_distance
        if distance1 < distance2
          minimum_distance = distance1
          current_curve = curve1
        else
          minimum_distance = distance2
          current_curve = curve2
        end
      end
      if minimum_distance < minimum_distance_threshold
        minimum_distance
      else
        last_minimum_distance
      end
    end
  end
end
