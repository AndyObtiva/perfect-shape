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
  # Superclass of all shapes. Not meant to be used directly.
  # Subclasses must implement/override methods as needed.
  class Shape
    # Subclasses must implement
    def min_x
    end
    
    # Subclasses must implement
    def min_y
    end
    
    # Subclasses must implement
    def max_x
    end
    
    # Subclasses must implement
    def max_y
    end
    
    # Default implementation is max_x - min_x
    # Subclasses can override
    def width
      max_x - min_x if max_x && min_x
    end
    
    # Default implementation is max_y - min_y
    # Subclasses can override
    def height
      max_y - min_y if max_y && min_y
    end
    
    # center_x is min_x + width/2.0 by default
    # Returns nil if min_x or width are nil
    def center_x
      min_x + width / BigDecimal('2.0') if min_x && width
    end
    
    # center_y is min_y + height/2.0 by default
    # Returns nil if min_y or height are nil
    def center_y
      min_y + height / BigDecimal('2.0') if min_y && height
    end
    
    # Rectangle with x = self.min_x, y = self.min_y, width = self.width, height = self.height
    def bounding_box
      require 'perfect_shape/rectangle'
      Rectangle.new(x: min_x, y: min_y, width: width, height: height)
    end
  
    # Normalizes point args whether two-number Array or x, y args returning
    # normalized point array of two BigDecimal's
    #
    # @param x_or_point The point or X coordinate of the point to test.
    # @param y The Y coordinate of the point to test.
    #
    # @return Array of x and y BigDecimal's representing point
    def normalize_point(x_or_point, y = nil)
      x = x_or_point
      x, y = x if y.nil? && x_or_point.is_a?(Array) && x_or_point.size == 2
      x = BigDecimal(x.to_s)
      y = BigDecimal(y.to_s)
      [x, y]
    end
    
    # Subclasses must implement
    def ==(other)
    end
  end
end
