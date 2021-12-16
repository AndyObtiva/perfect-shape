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

require 'perfect_shape/ellipse'

module PerfectShape
  class Circle < Ellipse
    def initialize(x: 0, y: 0, width: nil, height: nil, diameter: nil, center_x: nil, center_y: nil, radius_x: nil, radius_y: nil, radius: nil)
      if center_x && center_y && (radius || radius_x || radius_y)
        radius ||= radius_x || radius_y
        self.radius = radius
        super(center_x: center_x, center_y: center_y, radius_x: self.radius_x, radius_y: self.radius_y)
      else
        diameter ||= width || height || 1
        self.diameter = diameter
        super(x: x, y: y, width: self.width, height: self.height)
      end
    end
    
    def diameter
      @radius ? @radius * BigDecimal('2.0') : @diameter
    end
    
    def radius
      @diameter ? @diameter / BigDecimal('2.0') : @radius
    end
    
    # Sets length, normalizing to BigDecimal
    def diameter=(value)
      @diameter = BigDecimal(value.to_s)
      @radius = nil
      self.width = value unless width == value
      self.height = value unless height == value
    end
    
    # Sets radius, normalizing to BigDecimal
    def radius=(value)
      @radius = BigDecimal(value.to_s)
      @diameter = nil
      self.radius_x = value unless width == value
      self.radius_y = value unless height == value
    end
  end
end
