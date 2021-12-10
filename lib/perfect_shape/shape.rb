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
  class Shape
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
  end
end
