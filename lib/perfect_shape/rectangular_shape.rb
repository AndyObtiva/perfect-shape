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
  # Mixin Module for Rectangular Shapes (having x, y, width, height)
  # Can only be mixed into a class extending Shape or another module
  module RectangularShape
    # Calls super before setting x, y, width, height
    def initialize(x: 0, y: 0, width: 1, height: 1, center_x: nil, center_y: nil, radius_x: nil, radius_y: nil)
      super()
      if center_x && center_y && radius_x && radius_y
        self.center_x = center_x
        self.center_y = center_y
        self.radius_x = radius_x
        self.radius_y = radius_y
      else
        self.x = x
        self.y = y
        self.width = width
        self.height = height
      end
    end
    
    def x
      @center_x && @radius_x ? @center_x - @radius_x : @x
    end
    
    def y
      @center_y && @radius_y ? @center_y - @radius_y : @y
    end
    
    def width
      @radius_x ? @radius_x * BigDecimal('2.0') : @width
    end
    
    def height
      @radius_y ? @radius_y * BigDecimal('2.0') : @height
    end
    
    # Sets x, normalizing to BigDecimal
    def x=(value)
      @x = BigDecimal(value.to_s)
      @center_x = nil
      self.width = width if @radius_x
    end
    
    # Sets y, normalizing to BigDecimal
    def y=(value)
      @y = BigDecimal(value.to_s)
      @center_y = nil
      self.height = height if @radius_y
    end
    
    # Sets width, normalizing to BigDecimal
    def width=(value)
      @width = BigDecimal(value.to_s)
      @radius_x = nil
    end
    
    # Sets height, normalizing to BigDecimal
    def height=(value)
      @height = BigDecimal(value.to_s)
      @radius_y = nil
    end
    
    def center_x
      @x && @width ? @x + (@width/BigDecimal('2.0')) : @center_x
    end
    
    def center_y
      @y && @height ? @y + (@height/BigDecimal('2.0')) : @center_y
    end
    
    def radius_x
      @width ? @width/BigDecimal('2.0') : @radius_x
    end
    
    def radius_y
      @height ? @height/BigDecimal('2.0') : @radius_y
    end
    
    def center_x=(value)
      @center_x = BigDecimal(value.to_s)
      @x = nil
      self.radius_x = radius_x if @width
    end
    
    def center_y=(value)
      @center_y = BigDecimal(value.to_s)
      @y = nil
      self.radius_y = radius_y if @height
    end
    
    def radius_x=(value)
      @radius_x = BigDecimal(value.to_s)
      @width = nil
    end
    
    def radius_y=(value)
      @radius_y = BigDecimal(value.to_s)
      @height = nil
    end
  end
end
