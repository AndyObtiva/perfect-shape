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
      def point_crossings(x1, y1, xc, yc, x2, y2, px, py, level = 0)
        # TODO
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
      
      # TODO
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
