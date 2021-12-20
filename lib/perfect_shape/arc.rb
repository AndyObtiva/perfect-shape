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
require 'perfect_shape/rectangular_shape'
require 'perfect_shape/line'

module PerfectShape
  # Mostly ported from java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/Arc2D.html
  class Arc < Shape
    include RectangularShape
    include Equalizer.new(:type, :x, :y, :width, :height, :start, :extent)
    
    TYPES = [:open, :chord, :pie]
    attr_accessor :type
    attr_reader :start, :extent
    
    def initialize(type: :open, x: 0, y: 0, width: 1, height: 1, start: 0, extent: 360, center_x: nil, center_y: nil, radius_x: nil, radius_y: nil)
      if center_x && center_y && radius_x && radius_y
        self.center_x = center_x
        self.center_y = center_y
        self.radius_x = radius_x
        self.radius_y = radius_y
      else
        super(x: x, y: y, width: width, height: height)
      end
      @type = type
      self.start = start
      self.extent = extent
    end
    
    def start=(value)
      @start = BigDecimal(value.to_s)
    end
    
    def extent=(value)
      @extent = BigDecimal(value.to_s)
    end
    
    def x
      @center_x && @radius_x ? @center_x - @radius_x : super
    end
    
    def y
      @center_y && @radius_y ? @center_y - @radius_y : super
    end
    
    def width
      @radius_x ? @radius_x * BigDecimal('2.0') : super
    end
    
    def height
      @radius_y ? @radius_y * BigDecimal('2.0') : super
    end
    
    # Sets x, normalizing to BigDecimal
    def x=(value)
      super
      @center_x = nil
      self.width = width if @radius_x
    end
    
    # Sets y, normalizing to BigDecimal
    def y=(value)
      super
      @center_y = nil
      self.height = height if @radius_y
    end
    
    # Sets width, normalizing to BigDecimal
    def width=(value)
      super
      @radius_x = nil
    end
    
    # Sets height, normalizing to BigDecimal
    def height=(value)
      super
      @radius_y = nil
    end
    
    def center_x
      super || @center_x
    end
    
    def center_y
      super || @center_y
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
    
    # Checks if arc contains point denoted by point (two-number Array or x, y args)
    #
    # @param x The X coordinate of the point to test.
    # @param y The Y coordinate of the point to test.
    #
    # @return {@code true} if the point lies within the bound of
    # the arc, {@code false} if the point lies outside of the
    # arc's bounds.
    def contain?(x_or_point, y = nil)
      x, y = normalize_point(x_or_point, y)
      return unless x && y
      # Normalize the coordinates compared to the ellipse
      # having a center at 0,0 and a radius of 0.5.
      ellw = width
      return false if (ellw <= 0.0)
      normx = (x - self.x) / ellw - 0.5
      ellh = height
      return false if (ellh <= 0.0)
      normy = (y - self.y) / ellh - 0.5
      dist_sq = (normx * normx) + (normy * normy)
      return false if (dist_sq >= 0.25)
      ang_ext = self.extent.abs
      return true if (ang_ext >= 360.0)
      inarc = contain_angle?(-1*Math.radians_to_degrees(Math.atan2(normy, normx)))
      
      return inarc if type == :pie
      # CHORD and OPEN behave the same way
      if inarc
        return true if ang_ext >= 180.0
        # point must be outside the "pie triangle"
      else
        return false if ang_ext <= 180.0
        # point must be inside the "pie triangle"
      end
      
      # The point is inside the pie triangle iff it is on the same
      # side of the line connecting the ends of the arc as the center.
      angle = Math.degrees_to_radians(-start)
      x1 = Math.cos(angle)
      y1 = Math.sin(angle)
      angle += Math.degrees_to_radians(-extent)
      x2 = Math.cos(angle)
      y2 = Math.sin(angle)
      inside = (Line.relative_counterclockwise(x1, y1, x2, y2, 2*normx, 2*normy) *
                        Line.relative_counterclockwise(x1, y1, x2, y2, 0, 0) >= 0)
      inarc ? !inside : inside
    end
    
    # Determines whether or not the specified angle is within the
    # angular extents of the arc.
    def contain_angle?(angle)
      ang_ext = self.extent
      backwards = ang_ext < 0.0
      ang_ext = -ang_ext if backwards
      return true if ang_ext >= 360.0

      angle = Math.normalize_degrees(angle) - Math.normalize_degrees(start)
      angle = -angle if backwards
      angle += 360.0 if angle < 0.0

      (angle >= 0.0) && (angle < ang_ext)
    end
  end
end
