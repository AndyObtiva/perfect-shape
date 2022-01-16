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
  
    # TODO document initialize in full detail
    def initialize(xxp: nil, xyp: nil, yxp: nil, yyp: nil, xt: nil, yt: nil,
                   m11: nil, m12: nil, m21: nil, m22: nil, m13: nil, m23: nil)
      self.xxp = xxp || m11
      self.xyp = xyp || m12
      self.yxp = yxp || m21
      self.yyp = yyp || m22
      self.xt = xt || m13
      self.yt = yt || m23
    end
  end
end
