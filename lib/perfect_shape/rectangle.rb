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

module PerfectShape
  # Mostly ported from java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/Rectangle2D.html
  class Rectangle
    attr_reader :x, :y, :width, :height
    
    def initialize(x: 0, y: 0, width: 1, height: 1)
      self.x = x
      self.y = y
      self.width = width
      self.height = height
    end
    
    def x=(value)
      @x = BigDecimal(value.to_s)
    end
    
    def y=(value)
      @y = BigDecimal(value.to_s)
    end
    
    def width=(value)
      @width = BigDecimal(value.to_s)
    end
    
    def height=(value)
      @height = BigDecimal(value.to_s)
    end
    
    # Checks if rectangle contains point denoted by point (two-number Array or x, y args)
    #
    # @param x The X coordinate of the point to test.
    # @param y The Y coordinate of the point to test.
    #
    # @return {@code true} if the point lies within the bound of
    # the rectangle, {@code false} if the point lies outside of the
    # rectangle's bounds.
    def contain?(x_or_point, y = nil)
      x = x_or_point
      x, y = x if y.nil? && x_or_point.is_a?(Array) && x_or_point.size == 2
      x = BigDecimal(x.to_s)
      y = BigDecimal(y.to_s)
      x.between?(@x, @x + @width) && y.between?(@y, @y + @height)
    end
  end
end
