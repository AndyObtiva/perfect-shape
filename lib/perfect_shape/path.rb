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
require 'perfect_shape/multi_point'

module PerfectShape
  # Mostly ported from java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/Path2D.html
  class Path < Shape
    include MultiPoint
    
    WINDING_RULES = [:wind_non_zero, :wind_even_odd]
    
    attr_accessor :shapes, :closed, :winding_rule
    alias closed? closed
    
    def initialize(shapes: [], closed: false, winding_rule: :wind_non_zero)
      self.closed = closed
      self.winding_rule = winding_rule
      self.shapes = shapes
    end
    
    def points
      @shapes.map do |shape|
        case shape
        when Point
          shape.to_a
        when Array
          shape
        when Line
          shape.points.last.to_a
#         when QuadraticBezierCurve # TODO
#         when CubicBezierCurve # TODO
        end
      end.tap do |the_points|
        the_points << @shapes.first.to_a if closed?
      end
    end
    
    def drawing_types
      the_drawing_shapes = @shapes.map do |shape|
        case shape
        when Point
          :move_to
        when Array
          :move_to
        when Line
          :line_to
#         when QuadraticBezierCurve # TODO
#         when CubicBezierCurve # TODO
        end
      end
      the_drawing_shapes << :close if closed?
      the_drawing_shapes
    end
  end
end
