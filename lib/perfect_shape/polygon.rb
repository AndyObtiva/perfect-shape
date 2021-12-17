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

module PerfectShape
  # Mostly ported from java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/Polygon.html
  class Polygon < Shape
    attr_reader :points
    
    def initialize(points: nil)
      self.points = points || []
    end
    
    def points=(the_points)
      unless the_points.first.is_a?(Array)
        xs = the_points.each_with_index.select {|n, i| i.even?}.map(&:first)
        ys = the_points.each_with_index.select {|n, i| i.odd?}.map(&:first)
        the_points = xs.zip(ys)
      end
      @points = the_points
    end
    
    def min_x
      points.map(&:first).min
    end
    
    def min_y
      points.map(&:last).min
    end
    
    def max_x
      points.map(&:first).max
    end
    
    def max_y
      points.map(&:last).max
    end
    
    def width
      max_x - min_x if min_x && max_x
    end
    
    def height
      max_y - min_y if min_y && max_y
    end
    
    # Checks if polygon contains point denoted by point (two-number Array or x, y args) using the ray casting algorithm (aka odd-even rule)
    #
    # @param x The X coordinate of the point to test.
    # @param y The Y coordinate of the point to test.
    #
    # @return {@code true} if the point lies within the bound of
    # the polygon, {@code false} if the point lies outside of the
    # polygon's bounds.
#     def contain?(x_or_point, y = nil)
      # TODO
#       x, y = normalize_point(x_or_point, y)
#       return unless x && y
#       x.between?(self.x, self.x + self.width) && y.between?(self.y, self.y + self.height)
#     end
  end
end
