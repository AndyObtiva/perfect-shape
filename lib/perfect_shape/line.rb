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
  # Mostly ported from java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/Line2D.html
  class Line
    class << self
      # Returns an indicator of where the specified point
      # {@code (px,py)} lies with respect to the line segment from
      # {@code (x1,y1)} to {@code (x2,y2)}.
      # The return value can be either 1, -1, or 0 and indicates
      # in which direction the specified line must pivot around its
      # first end point, {@code (x1,y1)}, in order to point at the
      # specified point {@code (px,py)}.
      # <p>A return value of 1 indicates that the line segment must
      # turn in the direction that takes the positive X axis towards
      # the negative Y axis.  In the default coordinate system used by
      # Java 2D, this direction is counterclockwise.
      # <p>A return value of -1 indicates that the line segment must
      # turn in the direction that takes the positive X axis towards
      # the positive Y axis.  In the default coordinate system, this
      # direction is clockwise.
      # <p>A return value of 0 indicates that the point lies
      # exactly on the line segment.  Note that an indicator value
      # of 0 is rare and not useful for determining collinearity
      # because of floating point rounding issues.
      # <p>If the point is colinear with the line segment, but
      # not between the end points, then the value will be -1 if the point
      # lies "beyond {@code (x1,y1)}" or 1 if the point lies
      # "beyond {@code (x2,y2)}".
      #
      # @param x1 the X coordinate of the start point of the
      #           specified line segment
      # @param y1 the Y coordinate of the start point of the
      #           specified line segment
      # @param x2 the X coordinate of the end point of the
      #           specified line segment
      # @param y2 the Y coordinate of the end point of the
      #           specified line segment
      # @param px the X coordinate of the specified point to be
      #           compared with the specified line segment
      # @param py the Y coordinate of the specified point to be
      #           compared with the specified line segment
      # @return an integer that indicates the position of the third specified
      #                  coordinates with respect to the line segment formed
      #                  by the first two specified coordinates.
      # @since 1.2
      def relative_ccw(x1, y1, x2, y2, px, py)
        x2 -= x1;
        y2 -= y1;
        px -= x1;
        py -= y1;
        ccw = px * y2 - py * x2;
        if ccw == 0.0
          # The point is colinear, classify based on which side of
          # the segment the point falls on.  We can calculate a
          # relative value using the projection of px,py onto the
          # segment - a negative value indicates the point projects
          # outside of the segment in the direction of the particular
          # endpoint used as the origin for the projection.
          ccw = px * x2 + py * y2;
          if ccw > 0.0
            # Reverse the projection to be relative to the original x2,y2
            # x2 and y2 are simply negated.
            # px and py need to have (x2 - x1) or (y2 - y1) subtracted
            #    from them (based on the original values)
            # Since we really want to get a positive answer when the
            #    point is "beyond (x2,y2)", then we want to calculate
            #    the inverse anyway - thus we leave x2 & y2 negated.
            px -= x2;
            py -= y2;
            ccw = px * x2 + py * y2;
            ccw = 0.0 if ccw < 0.0
          end
        end
        (ccw < 0.0) ? -1 : ((ccw > 0.0) ? 1 : 0);
      end
    end
  end
end
