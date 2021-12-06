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

require_relative 'line'

module PerfectShape
  class Arc
    TYPES = [:open, :chord, :pie]
    attr_accessor :type, :x, :y, :width, :height, :start, :extent
    
    def initialize(type: :open, x: 0, y: 0, width: 1, height: 1, start: 0, extent: 360)
      @type = type
      self.x = x
      self.y = y
      self.width = width
      self.height = height
      self.start = start
      self.extent = extent
    end
    
    def x=(value)
      @x = BigDecimal(value.to_s)
    end
    
    def y=(value)
      @y = BigDecimal(value.to_s)
    end
    
    def width=(value)
      @width = BigDecimal(value.to_s)
    end
    
    def height=(value)
      @height = BigDecimal(value.to_s)
    end
    
    def start=(value)
      @start = BigDecimal(value.to_s)
    end
    
    def extent=(value)
      @extent = BigDecimal(value.to_s)
    end
    
    def contain?(x_or_point, y = nil)
      x = x_or_point
      x, y = x if y.nil? && x_or_point.is_a?(Array) && x_or_point.size == 2
      x = BigDecimal(x.to_s)
      y = BigDecimal(y.to_s)
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
      inarc = contain_angle?(-1*radians_to_degrees(Math.atan2(normy, normx)))
      
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
      angle = radians_to_degrees(-start)
      x1 = Math.cos(angle)
      y1 = Math.sin(angle)
      angle += radians_to_degrees(-getAngleExtent())
      x2 = Math.cos(angle)
      y2 = Math.sin(angle)
      inside = (Line.relativeCCW(x1, y1, x2, y2, 2*normx, 2*normy) *
                        Line.relativeCCW(x1, y1, x2, y2, 0, 0) >= 0)
      inarc ? !inside : inside
    end
    
    def contain_angle?(angle)
      ang_ext = self.extent
      backwards = ang_ext < 0.0
      ang_ext = -ang_ext if backwards
      return true if ang_ext >= 360.0

      angle = normalize_degrees(angle) - normalize_degrees(getAngleStart())
      angle = -angle if backwards
      angle += 360.0 if angle < 0.0

      (angle >= 0.0) && (angle < ang_ext)
    end
    
    def normalize_degrees(angle)
      if angle > 180.0
        if angle <= (180.0 + 360.0)
          angle = angle - 360.0
        else
          angle = Math.ieee_remainder(angle, 360.0)
          # IEEEremainder can return -180 here for some input values...
          angle = 180.0 if angle == -180.0
        end
      elsif angle <= -180.0
        if angle > (-180.0 - 360.0)
          angle = angle + 360.0
        else
          angle = Math.ieee_remainder(angle, 360.0)
          # IEEEremainder can return -180 here for some input values...
          angle = 180.0 if angle == -180.0
        end
      end
      angle
    end
    
    def radians_to_degrees(radians)
      (180/Math::PI)*radians
    end
  end
end
