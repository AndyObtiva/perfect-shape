# TODO

## Next

- `Path` can contain another `Path`

## Issues

- PerfectShape::CubicBezierCurve#contain?(x, y, outline: true, distance_tolerance: 5) is not working consistently along the curve of the cubic bezier curve (it is possible the same issue occurs for quadratic bezier curves too)

## Far Future

- Make PerfectShape::Path accept getting constructed without a point at the beginning if the first path shape had all its points (was not missing the first point) and otherwise display a better error message if the first point is missing
- `Polyline`
- `Polybezier`
- `PerfectShape::RoundRectangle` (rectangle with arc corners)
- `PerfectShape::Triangle` (a special case of `PerfectShape::Polygon` and `PerfectShape::Path`). Also, support RightTriangle and Equilateral Triangle.
- `Shape#area` for all shapes
- `Shape#intersection_area(other_shape)` for all shapes (this helps with improved drag and drop deciding which drop target overlap the dragged source with the biggest area)
- `Line#parallel?(other_line)`
- `Arc#point_distance`, `Ellipse#point_distance`, and `Circle#point_distance`
- `Rectangle#point_distance`, `Square#point_distance`, and `Polygon#point_distance`
- `Path#point_distance`
- `CompositeShape#point_distance`
- `PerfectShape::Line#point_line_distance` or `PerfectShape::Ray#point_distance` (distance from line ray vector not just line segment)

## Maybe

- Report issue in JRuby with highly repeated operations like `xc1 = (x1 + xc1) / 2.0` slowing performance of running specs to a crawl (hanging completely) unless I update code to `xc1 = BigDecimal((x1 + xc1).to_s) / 2;`
- Consider contributing IEEEremainder to Ruby
- Contribute this type of expectation: `_(arc).must_be :contain?, *point` to Minitest Expectations
- Maybe contribute xit to minitest expectations
- Support non-kwargs as alternative in all shapes' constructors
- Report weird issue with tests taking too long in jruby due to BigDecimal use in `QuadraticBezierCurve::point_crossings` in commit `b48d66313e429fb60339c87c7d6b1b165ff4e7d8`
- Support `PerfectShape::Point` everywhere `[x, y]` is accepted
- Override `PerfectShape::Shape#inspect` to auto-convert all `BigDecimal`s with `to_s('f')` for better readability
- `Line#overlap_line?(other_line)`: checks if it overlaps with other line
- `Line#contain_line?(other_line)`: checks if it contains other line completely
- `Line#intersect_line?(other_line)`: checks if it intersects with other line
- `Line#angle(other_line)`
- Support `Ray`
- Support `Vector`
- Support `Shape#center_point` method (`[center_x, center_y]`)
- Add `#size`/`#size=` as aliases for `#length`/`#length=` in `PerfectShape::Square`
- `Shape#to_s` readable format for all shapes
- Enable `Point#[0]`, `Point#[1]` (and `first`/`last`) to return `x` and `y` just like an `Array` point works, also supporting `[]=` similarly too.
- Support `Pt[x, y]` syntax for constructing a `PerfectShape::Point`
- Consider supporting `Math::to_big_decimal` or `Numeric#to_big_decimal` to automate complications like checking if a number is `BigDecimal` first before enhancing it to avoid object/memory waste
- `PerfectShape::AffineTransform#mirror!`
- Preserve straightness and parallelness of lines during rotation by giving 90/180/270 degree rotations special logic (e.g. rotate (10, 10) by 90 should give (-10, 10) not (-9.99999, 10.00001))
- `AffineTransform#rotate_by_vector(x, y)`
- Understand why rotate in SWT works differently from standard Matrix rotate algorithm
- non-`!` versions of mutation methods on `AffineTransform`
- Rotate around a point instead of origin (0, 0) for convenience (translates by x,y amount, rotates, and then translates by -x, -y amount)
- `Point#affine_transform(affine_transform)`
- `Point#inverse_affine_transform(affine_transform)`
- `MultiPoint#affine_transform(affine_transform)` on `Line`, `QuadraticBezierCurve`, `CubicBezierCurve`, `Polygon`, and `Path`
- `MultiPoint#inverse_affine_transform(affine_transform)` on `Line`, `QuadraticBezierCurve`, `CubicBezierCurve`, `Polygon`, and `Path`
- Update all `#contain?` implementations to become `#contain?(..., affine_transform: )` or to allow alternatively setting `affine_transform=` on `Shape`, and later inverse-transform point before calculation if `:affine_transform` option is supplied
- [Polygon Triangulation](https://en.wikipedia.org/wiki/Polygon_triangulation)
- `PerfectShape::Polyline`: multiple lines
- `PerfectShape::Polycubic`: multiple cubic bezier curves
- `PerfectShape::Polyquad`: multiple quadratic bezier curves
- Support specifying distance_tolerance direction of either to the outside of the shape or to the inside of the shape (otherwise support a shape auto-growing correctly if outline thickness is specified to automatically calculate if point is on outline correctly with the right fuzz factor)
