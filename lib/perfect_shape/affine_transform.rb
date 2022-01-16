# Copyright (c) 2021-2022 Andy Maleh
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
  # Represents an affine transform
  class AffineTransform
    include Equalizer.new(:xxp, :xyp, :yxp, :yyp, :xt, :yt)
  
    attr_accessor :xxp, :xyp, :yxp, :yyp, :xt, :yt
    alias m11 xxp
    alias m11= xxp=
    alias m12 xyp
    alias m12= xyp=
    alias m21 yxp
    alias m21= yxp=
    alias m22 yyp
    alias m22= yyp=
    alias m13 xt
    alias m13= xt=
    alias m23 yt
    alias m23= yt=
  
    # Creates a new AffineTransform with the following Matrix:
    #
    # [ xxp xyp xt ]
    # [ yxp yyp yt ]
    #
    # The Matrix is used to transform (x,y) point coordinates as follows:
    #
    # [ xxp xyp xt ] * [x] = [ xxp * x + xyp * y + xt ]
    # [ yxp yyp yt ] * [y] = [ yxp * x + yyp * y + yt ]
    #
    # xxp is the x coordinate x product (m11)
    # xyp is the x coordinate y product (m12)
    # yxp is the y coordinate x product (m21)
    # yyp is the y coordinate y product (m22)
    # xt is the x coordinate translation (m13)
    # yt is the y coordinate translation (m23)
    #
    # The constructor accepts either the (x,y)-operation related argument/kwarg names
    # or traditional Matrix element kwarg names
    #
    # Example with (x,y)-operation kwarg names:
    #
    # AffineTransform.new(xxp: 2, xyp: 3, yxp: 4, yyp: 5, xt: 6, yt: 7)
    #
    # Example with traditional Matrix element kwarg names:
    #
    # AffineTransform.new(m11: 2, m12: 3, m21: 4, m22: 5, m13: 6, m23: 7)
    #
    # Example with standard arguments:
    #
    # AffineTransform.new(2, 3, 4, 5, 6, 7)
    #
    # If no arguments are supplied, it constructs an identity matrix
    # (i.e. like calling `::new(xxp: 1, xyp: 0, yxp: 0, yyp: 1, xt: 0, yt: 0)`)
    def initialize(xxp_element = nil, xyp_element = nil, yxp_element = nil, yyp_element = nil, xt_element = nil, yt_element = nil,
                   xxp: nil, xyp: nil, yxp: nil, yyp: nil, xt: nil, yt: nil,
                   m11: nil, m12: nil, m21: nil, m22: nil, m13: nil, m23: nil)
      self.xxp = BigDecimal((xxp_element || xxp || m11 || 1).to_s)
      self.xyp = BigDecimal((xyp_element || xyp || m12 || 0).to_s)
      self.yxp = BigDecimal((yxp_element || yxp || m21 || 0).to_s)
      self.yyp = BigDecimal((yyp_element || yyp || m22 || 1).to_s)
      self.xt  = BigDecimal((xt_element  || xt  || m13 || 0).to_s)
      self.yt  = BigDecimal((yt_element  || yt  || m23 || 0).to_s)
    end
    
    # TODO override attr writers to normalize values into big decimals
    
    def transform(x_or_point, y = nil)
      x, y = Point.normalize_point(x_or_point, y)
      return unless x && y
      
      [xxp*x + xyp*y + xt, yxp*x + yyp*y + yt]
    end
  end
end
