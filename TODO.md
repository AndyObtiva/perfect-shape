# TODO

## Next (Version 0.1.1)

- `PerfectShape::Path` add quadratic bezier curves
- Add https://raw.githubusercontent.com/AndyObtiva/perfect-shape/master to image paths in README

## Soon (Version 0.1.x)

- `PerfectShape::CubicBezierCurve` (2 control points)
- `PerfectShape::Path` add cubic bezier curves
- Add examples for all shapes in README

## Version 0.2.0

- `PerfectShape::CompositeShape`: aggregate of multiple shapes

## Version 0.3.0

- Support `contain?(outline: true)` on all shapes to compare against shape outline only (checking that point lies at the edge, not inside)

## Version 0.4.0

- `PerfectShape::AffineTransform`: represents a 2D affine transform that performs a linear mapping from 2D coordinates to other 2D coordinates that preserves the "straightness" and "parallelness" of lines.

## Version 1.0.0

- Shape `intersect?(rectangle)` method (helpful in determining if a shape shows up in a viewport in a GUI application)

## Geometry

Mostly inspired by java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/package-summary.html

- `PerfectShape::RoundRectangle` (rectangle with arc corners)
- `PerfectShape::Line#point_line_distance` (distance from line ray vector not just line segment)

## Miscellaneous

None

## Maybe

- Consider the idea of having tests run in JRuby and check against java.awt.geom and compare result with perfect-shape
- Consider contributing IEEEremainder to Ruby
- Contribute this type of expectation: `_(arc).must_be :contain?, *point` to Minitest Expectations
- Maybe contribute xit to minitest expectations
- Support non-kwargs as alternative in all shapes' constructors
