# TODO

## Geometry

Mostly inspired by java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/package-summary.html

- Polygon
- CubicCurve
- QuadCurve
- Line
- Path: flexible shape which represents an arbitrary geometric path
- GeneralPath: represents a geometric path constructed from straight lines, and quadratic and cubic (Bézier) curves. It can contain multiple subpaths.
- Rectangle
- RoundRectangle
- Point
- Ellipse
- Polybezier
- Polyline
- Area: aggregate of multiple shapes
- AffineTransform: represents a 2D affine transform that performs a linear mapping from 2D coordinates to other 2D coordinates that preserves the "straightness" and "parallelness" of lines.

## Miscellaneous

- Include screenshots of the supported shapes in README

## Maybe

- Consider the idea of having tests run in JRuby and check against java.awt.geom and compare result with perfect-shape
- Consider contributing IEEEremainder to Ruby
- Contribute this type of expectation: _(arc).must_be :contain?, *point to Minitest Expectations
- Maybe contribute xit to minitest expectations
