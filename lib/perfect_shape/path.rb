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
require 'perfect_shape/point'
require 'perfect_shape/line'
require 'perfect_shape/quadratic_bezier_curve'
require 'perfect_shape/cubic_bezier_curve'
require 'perfect_shape/multi_point'

module PerfectShape
  # Mostly ported from java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/Path2D.html
  class Path < Shape
    include MultiPoint
    include Equalizer.new(:shapes, :closed, :winding_rule)
    
    # Available class types for path shapes
    SHAPE_TYPES = [Array, PerfectShape::Point, PerfectShape::Line, PerfectShape::QuadraticBezierCurve, PerfectShape::CubicBezierCurve]
    
    # Available winding rules
    WINDING_RULES = [:wind_non_zero, :wind_even_odd]
    
    attr_reader :winding_rule
    attr_accessor :shapes, :closed
    alias closed? closed
    
    # Constructs Path with winding rule, closed status, and shapes (must always start with PerfectShape::Point or Array of [x,y] coordinates)
    # Shape class types can be any of SHAPE_TYPES: Array (x,y coordinates), PerfectShape::Point, or PerfectShape::Line
    # winding_rule can be any of WINDING_RULES: :wind_non_zero (default) or :wind_even_odd
    def initialize(shapes: [], closed: false, winding_rule: :wind_non_zero)
      self.closed = closed
      self.winding_rule = winding_rule
      self.shapes = shapes
    end
    
    def points
      the_points = []
      @shapes.each do |shape|
        case shape
        when Point
          the_points << shape.to_a
        when Array
          the_points << shape.map {|n| BigDecimal(n.to_s)}
        when Line
          the_points << shape.points.last.to_a
        when QuadraticBezierCurve
          shape.points.each do |point|
            the_points << point.to_a
          end
        when CubicBezierCurve
          shape.points.each do |point|
            the_points << point.to_a
          end
        end
      end
      the_points << @shapes.first.to_a if closed?
      the_points
    end
    
    def points=(some_points)
      raise "Cannot assign points directly! Must set shapes instead and points are calculated from them automatically."
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
        when QuadraticBezierCurve
          :quad_to
        when CubicBezierCurve
          :cubic_to
        end
      end
      the_drawing_shapes << :close if closed?
      the_drawing_shapes
    end
    
    def winding_rule=(value)
      raise "Invalid winding rule: #{value}" unless WINDING_RULES.include?(value.to_s.to_sym)
      @winding_rule = value
    end
    
    # Checks if path contains point (two-number Array or x, y args)
    # using the Nonzero-Rule (aka Winding Number Algorithm): https://en.wikipedia.org/wiki/Nonzero-rule
    # or using the Even-Odd Rule (aka Ray Casting Algorithm): https://en.wikipedia.org/wiki/Even%E2%80%93odd_rule
    #
    # @param x The X coordinate of the point to test.
    # @param y The Y coordinate of the point to test.
    #
    # @return {@code true} if the point lies within the bound of
    # the path, {@code false} if the point lies outside of the
    # path's bounds.
    def contain?(x_or_point, y = nil)
      x, y = normalize_point(x_or_point, y)
      return unless x && y
      if (x * 0.0 + y * 0.0) == 0.0
        # N * 0.0 is 0.0 only if N is finite.
        # Here we know that both x and y are finite.
        return false if shapes.count < 2
        mask = winding_rule == :wind_non_zero ? -1 : 1
        (point_crossings(x, y) & mask) != 0
      else
        # Either x or y was infinite or NaN.
        # A NaN always produces a negative response to any test
        # and Infinity values cannot be "inside" any path so
        # they should return false as well.
        false
      end
    end
    
    # Calculates the number of times the given path
    # crosses the ray extending to the right from (x,y).
    # If the point lies on a part of the path,
    # then no crossings are counted for that intersection.
    # +1 is added for each crossing where the Y coordinate is increasing
    # -1 is added for each crossing where the Y coordinate is decreasing
    # The return value is the sum of all crossings for every segment in
    # the path.
    # The path must start with a PerfectShape::Point (initial location)
    # The caller must check for NaN values.
    # The caller may also reject infinite values as well.
    def point_crossings(x_or_point, y = nil)
      x, y = normalize_point(x_or_point, y)
      return unless x && y
      return 0 if shapes.count == 0
      movx = movy = curx = cury = endx = endy = 0
      coords = points.flatten
      curx = movx = coords[0]
      cury = movy = coords[1]
      crossings = 0
      ci = 2
      1.upto(shapes.count - 1).each do |i|
        case drawing_types[i]
        when :move_to
          if cury != movy
            line = PerfectShape::Line.new(points: [[curx, cury], [movx, movy]])
            crossings += line.point_crossings(x, y)
          end
          movx = curx = coords[ci]
          ci += 1
          movy = cury = coords[ci]
          ci += 1
        when :line_to
          endx = coords[ci]
          ci += 1
          endy = coords[ci]
          ci += 1
          line = PerfectShape::Line.new(points: [[curx, cury], [endx, endy]])
          crossings += line.point_crossings(x, y)
          curx = endx;
          cury = endy;
        when :quad_to
          quad_ctrlx = coords[ci]
          ci += 1
          quad_ctrly = coords[ci]
          ci += 1
          endx = coords[ci]
          ci += 1
          endy = coords[ci]
          ci += 1
          quad = PerfectShape::QuadraticBezierCurve.new(points: [[curx, cury], [quad_ctrlx, quad_ctrly], [endx, endy]])
          crossings += quad.point_crossings(x, y)
          curx = endx;
          cury = endy;
        when :cubic_to
          cubic_ctrl1x = coords[ci]
          ci += 1
          cubic_ctrl1y = coords[ci]
          ci += 1
          cubic_ctrl2x = coords[ci]
          ci += 1
          cubic_ctrl2y = coords[ci]
          ci += 1
          endx = coords[ci]
          ci += 1
          endy = coords[ci]
          ci += 1
          cubic = PerfectShape::CubicBezierCurve.new(points: [[curx, cury], [cubic_ctrl1x, cubic_ctrl1y], [cubic_ctrl2x, cubic_ctrl2y], [endx, endy]])
          crossings += cubic.point_crossings(x, y)
          curx = endx;
          cury = endy;
        when :close
          if cury != movy
            line = PerfectShape::Line.new(points: [[curx, cury], [movx, movy]])
            crossings += line.point_crossings(x, y)
          end
          curx = movx
          cury = movy
        end
      end
      if cury != movy
        line = PerfectShape::Line.new(points: [[curx, cury], [movx, movy]])
        crossings += line.point_crossings(x, y)
      end
      crossings
    end
  end
end
