# TODO

## Next Version 0.3.2

- `PerfectShape::CubicBezierCurve#contain?(outline: true)`: check this: https://pomax.github.io/bezierinfo/#tracing and this: https://pomax.github.io/bezierinfo/chapters/projections/project.js
- `PerfectShape::CubicBezierCurve#contain?(outline: true, distance_tolernace: 1)`: check this: https://pomax.github.io/bezierinfo/#tracing and this: https://pomax.github.io/bezierinfo/chapters/projections/project.js
 
- Support `contain?(outline: true)` on all shapes to compare against shape outline only (checking that point lies at the edge, not inside)
For Bezier Curves, check this: https://pomax.github.io/bezierinfo/#projections and this: https://pomax.github.io/bezierinfo/chapters/projections/project.js
 - `PerfectShape::QuadraticBezierCurve#contain?(outline: true)`: check this: https://pomax.github.io/bezierinfo/#projections and this: https://pomax.github.io/bezierinfo/chapters/projections/project.js
 - `PerfectShape::Path#contain?(outline: true)`
 - `PerfectShape::CompositeShape#contain?(outline: true)`

## Version 0.4.0

- `PerfectShape::AffineTransform`: represents a 2D affine transform that performs a linear mapping from 2D coordinates to other 2D coordinates that preserves the "straightness" and "parallelness" of lines.
- `PerfectShape::AffineTransform#transform_point`
- `PerfectShape::AffineTransform#inverse_transform_point`
- `PerfectShape::AffineTransform#transform_points`
- `PerfectShape::AffineTransform#inverse_transform_points`
- `Point#affine_transform(affine_transform)`
- `MultiPoint#affine_transform(affine_transform)` on `Line`, `QuadraticBezierCurve`, `CubicBezierCurve`, `Polygon`, and `Path`
- Update all `#contain?` implementations to become `#contain?(..., affine_transform: )` and inverse-transform point before calculation if `:affine_transform` option is supplied
- Document affine transforms in README & gemspec intro

## Version 1.0.0

- Shape `intersect?(rectangle)` method (helpful in determining if a shape shows up in a viewport in a GUI application)
- Shape `intersect?(rectangle, affine_transform: )`
- Document intersection algorithm in README & gemspec intro

## Geometry

Mostly inspired by java.awt.geom: https://docs.oracle.com/javase/8/docs/api/java/awt/geom/package-summary.html

- `PerfectShape::RoundRectangle` (rectangle with arc corners)
- `PerfectShape::Line#point_line_distance` (distance from line ray vector not just line segment)
- `PerfectShape::Triangle` (a special case of `PerfectShape::Polygon` and `PerfectShape::Path`)

## Miscellaneous

None

## Maybe

- Consider the idea of having tests run in JRuby and check against java.awt.geom and compare result with perfect-shape
- Consider contributing IEEEremainder to Ruby
- Contribute this type of expectation: `_(arc).must_be :contain?, *point` to Minitest Expectations
- Maybe contribute xit to minitest expectations
- Support non-kwargs as alternative in all shapes' constructors
- Report weird issue with tests taking too long in jruby due to BigDecimal use in `QuadraticBezierCurve::point_crossings` in commit `b48d66313e429fb60339c87c7d6b1b165ff4e7d8`
- Support `PerfectShape::Point` everywhere `[x, y]` is accepted
