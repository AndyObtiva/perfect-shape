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
require 'perfect_shape/point'
require 'perfect_shape/multi_point'

module PerfectShape
  class Polygon < Shape
    include MultiPoint
    include Equalizer.new(:points)
    
    # Checks if polygon contains point (two-number Array or x, y args)
    # using the Ray Casting Algorithm (aka Even-Odd Rule): https://en.wikipedia.org/wiki/Point_in_polygon
    #
    # @param x The X coordinate of the point to test.
    # @param y The Y coordinate of the point to test.
    #
    # @return true if the point lies within the bound of
    # the polygon, false if the point lies outside of the
    # polygon's bounds.
    def contain?(x_or_point, y = nil, outline: false, distance_tolerance: 0)
      x, y = Point.normalize_point(x_or_point, y)
      return unless x && y
      if outline
        edges.any? { |edge| edge.contain?(x, y, distance_tolerance: distance_tolerance) }
      else
        npoints = points.count
        xpoints = points.map(&:first)
        ypoints = points.map(&:last)
        return false if npoints <= 2 || !bounding_box.contain?(x, y)
        hits = 0
  
        lastx = xpoints[npoints - 1]
        lasty = ypoints[npoints - 1]
  
        # Walk the edges of the polygon
        npoints.times do |i|
          curx = xpoints[i]
          cury = ypoints[i]
  
          if cury == lasty
            lastx = curx
            lasty = cury
            next
          end
  
          if curx < lastx
            if x >= lastx
              lastx = curx
              lasty = cury
              next
            end
            leftx = curx
          else
            if x >= curx
              lastx = curx
              lasty = cury
              next
            end
            leftx = lastx
          end
  
          if cury < lasty
            if y < cury || y >= lasty
              lastx = curx
              lasty = cury
              next
            end
            if x < leftx
              hits += 1
              lastx = curx
              lasty = cury
              next
            end
            test1 = x - curx
            test2 = y - cury
          else
            if y < lasty || y >= cury
              lastx = curx
              lasty = cury
              next
            end
            if x < leftx
              hits += 1
              lastx = curx
              lasty = cury
              next
            end
            test1 = x - lastx
            test2 = y - lasty
          end
  
          hits += 1 if (test1 < (test2 / (lasty - cury) * (lastx - curx)))
        end
  
        (hits & 1) != 0
      end
    end
    
    def edges
      points.zip(points.rotate(1)).map do |point1, point2|
        Line.new(points: [[point1.first, point1.last], [point2.first, point2.last]])
      end
    end
    
    def path
      path_shapes = []
      path_shapes << PerfectShape::Point.new(points[0])
      path_shapes += points[1..-1].map { |point| PerfectShape::Line.new(points: [point]) }
      PerfectShape::Path.new(shapes: path_shapes, closed: true)
    end
    
    def intersect?(rectangle)
      path.intersect?(rectangle)
    end
  end
end
