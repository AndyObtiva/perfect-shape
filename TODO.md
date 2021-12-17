# TODO

## Next

- Polygon

## Soon

- Path: represents a geometric path constructed from straight lines, and quadratic and cubic (Bézier) curves. It can contain multiple subpaths.

## Geometry

Mostly inspired by java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/package-summary.html

- QuadraticBezierCurve (1 control point)
- CubicBezierCurve (2 control points)
- Line
- Polyquad
- Polycubic
- Polyline
- Area: aggregate of multiple shapes
- Support `contain?(outline: true)` on all shapes to compare against shape outline only (checking that point lies at the edge, not inside)
- AffineTransform: represents a 2D affine transform that performs a linear mapping from 2D coordinates to other 2D coordinates that preserves the "straightness" and "parallelness" of lines.

- Point
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
