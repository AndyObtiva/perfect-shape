# TODO

## Next

- `PerfectShape::Line#relative_counter_clock_wise`
- `PerfectShape::Line#point_segment_distance`
- `PerfectShape::Point`

## Soon

- `PerfectShape::Path`: represents a geometric path constructed from straight lines and cubic (Bézier) curves.
- `PerfectShape::Path#Contain?`
- Embed absolute paths for images so that they show up in Ruby docs
- `PerfectShape::CubicBezierCurve` (2 control points)
- `PerfectShape::QuadraticBezierCurve` (1 control point) [have Path convert to CubicBezierCurve before adding]

## Geometry

Mostly inspired by java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/package-summary.html

- CompositeShape: aggregate of multiple shapes
- Support `contain?(outline: true)` on all shapes to compare against shape outline only (checking that point lies at the edge, not inside)
- Polyline
- Polycubic
- AffineTransform: represents a 2D affine transform that performs a linear mapping from 2D coordinates to other 2D coordinates that preserves the "straightness" and "parallelness" of lines.

- RoundRectangle
- Shape `intersect?(rectangle)` method

## Miscellaneous

None

## Maybe

- Consider the idea of having tests run in JRuby and check against java.awt.geom and compare result with perfect-shape
- Consider contributing IEEEremainder to Ruby
- Contribute this type of expectation: _(arc).must_be :contain?, *point to Minitest Expectations
- Maybe contribute xit to minitest expectations
- `RectangularShape` support of `bounds`, `min_x`, `max_x`, `min_y`, `max_y`
- `PerfectShape::Line#point_line_distance`
- Shape `intersect?(rectangle)` method (helpful in determining if a shape shows up in a viewport in a GUI application)
