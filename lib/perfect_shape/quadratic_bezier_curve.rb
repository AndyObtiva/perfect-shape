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
  class QuadraticBezierCurve < Shape
    class << self
      # TODO
    end
    
    include MultiPoint
    include Equalizer.new(:points)
    
    # Checks if quadratic bézier curve contains point (two-number Array or x, y args)
    #
    # @param x The X coordinate of the point to test.
    # @param y The Y coordinate of the point to test.
    #
    # @return {@code true} if the point lies within the bound of
    # the quadratic bézier curve, {@code false} if the point lies outside of the
    # quadratic bézier curve's bounds.
    def contain?(x_or_point, y = nil, distance: 0)
      x, y = normalize_point(x_or_point, y)
      return unless x && y

      x1 = points[0][0]
      y1 = points[0][1]
      xc = points[1][0]
      yc = points[1][1]
      x2 = points[2][0]
      y2 = points[2][1]

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
    
    # TODO
    def point_crossings(x_or_point, y = nil)
      x, y = normalize_point(x_or_point, y)
      return unless x && y
      # TODO
    end
  end
end