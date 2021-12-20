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
  class Point < Shape
    class << self
    end
    
    attr_reader :x, :y
    
    def initialize(x_or_point = 0, y = 0)
      if x_or_point.is_a?(Array)
        self.x, self.y = x_or_point
      else
        self.x = x_or_point
        self.y = y
      end
    end
    
    # Sets x, normalizing to BigDecimal
    def x=(value)
      @x = BigDecimal(value.to_s)
    end
    
    # Sets y, normalizing to BigDecimal
    def y=(value)
      @y = BigDecimal(value.to_s)
    end
    
    def min_x
      x
    end
    
    def min_y
      y
    end
    
    def max_x
      x
    end
    
    def max_y
      y
    end
    
    # Checks if points match, with distance tolerance (0 by default)
    #
    # @param x The X coordinate of the point to test.
    # @param y The Y coordinate of the point to test.
    # @param distance The distance from point to tolerate (0 by default)
    #
    # @return {@code true} if the point is close enough within distance tolerance,
    # {@code false} if the point is too far.
    def contain?(x_or_point, y = nil, distance: 0)
      x, y = normalize_point(x_or_point, y)
      return unless x && y
      distance = BigDecimal(distance.to_s)
    end
  end
end
