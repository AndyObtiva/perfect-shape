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
    attr_reader :x, :y, :width, :height
    
    # Calls super before setting x, y, width, height
    def initialize(x: 0, y: 0, width: 1, height: 1)
      super()
      self.x = x
      self.y = y
      self.width = width
      self.height = height
    end
    
    # Sets x, normalizing to BigDecimal
    def x=(value)
      @x = BigDecimal(value.to_s)
    end
    
    # Sets y, normalizing to BigDecimal
    def y=(value)
      @y = BigDecimal(value.to_s)
    end
    
    # Sets width, normalizing to BigDecimal
    def width=(value)
      @width = BigDecimal(value.to_s)
    end
    
    # Sets height, normalizing to BigDecimal
    def height=(value)
      @height = BigDecimal(value.to_s)
    end
    
    def center_x
      @x + (@width/BigDecimal('2.0')) if @x && @width
    end
    
    def center_y
      @y + (@height/BigDecimal('2.0')) if @y && @height
    end
  end
end