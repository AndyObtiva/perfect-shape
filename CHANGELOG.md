# Change Log

## 0.3.0

- Refactoring: rename `distance` option for `#contain?` on `Point`/`Line` into `distance_tolerance`
- Check point containment in rectangle outline with distance tolerance: `PerfectShape::Rectangle#contain?(x_or_point, y = nil, outline: false, distance_tolerance: 0)`
- Check point containment in square outline with distance tolerance: `PerfectShape::Square#contain?(x_or_point, y = nil, outline: false, distance_tolerance: 0)`

## 0.2.0

- `PerfectShape::CompositeShape`: aggregate of multiple shapes
- `PerfectShape::CompositeShape#contain?(x_or_point, y=nil)`
- `PerfectShape::CompositeShape#==`

## 0.1.2

- `PerfectShape::CubicBezierCurve` (two end points and two control points)
- `PerfectShape::CubicBezierCurve#contain?(x_or_point, y=nil)`
- `PerfectShape::CubicBezierCurve#==`
- `PerfectShape::Path` having cubic bezier curves in addition to points, lines, and quadratic bezier curves

## 0.1.1

- `PerfectShape::QuadraticBezierCurve` (two end points and one control point)
- `PerfectShape::QuadraticBezierCurve#contain?(x_or_point, y=nil)`
- `PerfectShape::QuadraticBezierCurve#==`
- `PerfectShape::Path` having quadratic bezier curves in addition to points and lines

## 0.1.0

- `PerfectShape::Path` (having points or lines)
- `PerfectShape::Path#contain?(x_or_point, y=nil, distance_tolerance: 0)`
- `PerfectShape::Path#point_crossings(x_or_point, y=nil)`
- `PerfectShape::Path#==`

## 0.0.11

- `PerfectShape::Polygon#==`
- `PerfectShape::Line#==`
- `PerfectShape::Point#==`

## 0.0.10

- `PerfectShape::Point`
- `PerfectShape::Point#point_distance`
- `PerfectShape::Point#contain?(x_or_point, y=nil, distance_tolerance: 0)`
- Refactor `PerfectShape::Point`,`PerfectShape::RectangularShape` to include shared `PerfectShape::PointLocation`

## 0.0.9

- `PerfectShape::Line#contain?(x_or_point, y=nil, distance_tolerance: 0)` (add a distance tolerance fuzz factor option)

## 0.0.8

- `PerfectShape::Line`
- `PerfectShape::Line#contain?(x_or_point, y=nil)`
- `PerfectShape::Line#relative_counterclockwise`
- `PerfectShape::Line#point_segment_distance`
- Update `PerfectShape::Math::radians_to_degrees`, `PerfectShape::Math::degrees_to_radians`, and `PerfectShape::Math::normalize_degrees` to normalize numbers to `BigDecimal`

## 0.0.7

- `PerfectShape::Polygon`
- `PerfectShape::Polygon#contain?(x_or_point, y)` (Ray Casting Algorithm, aka Even-Odd Rule)
- `PerfectShape::Shape#min_x`/`PerfectShape::Shape#min_y`/`PerfectShape::Shape#max_x`/`PerfectShape::Shape#max_y`/`PerfectShape::Shape#center_x`/`PerfectShape::Shape#center_y`/`PerfectShape::Shape#bounding_box`

## 0.0.6

- `PerfectShape::Circle`
- `PerfectShape::Circle#contain?(x_or_point, y=nil)`

## 0.0.5

- `PerfectShape::Ellipse`
- `PerfectShape::Ellipse#contain?(x_or_point, y=nil)`

## 0.0.4

- `PerfectShape::Arc#center_x` / `PerfectShape::Arc#center_y` / `PerfectShape::Arc#radius_x` / `PerfectShape::Arc#radius_y`
- `PerfectShape::Rectangle#center_x` / `PerfectShape::Arc#center_y`
- `PerfectShape::Square#center_x` / `PerfectShape::Square#center_y`
- `PerfectShape::Arc#initialize(center_x: , center_y: , radius_x: , radius_y: )`
- `PerfectShape::Math::normalize_degrees(degrees)` extracted from `PerfectShape::Arc`

## 0.0.3

- `PerfectShape::Square`
- `PerfectShape::Square#contain?(x_or_point, y=nil)`

## 0.0.2

- `PerfectShape::Rectangle`
- `PerfectShape::Rectangle#contain?(x_or_point, y=nil)`

## 0.0.1

- `PerfectShape::Math`
- `PerfectShape::Math::ieee_remainder` (alias: `ieee754_remainder`)
- `PerfectShape::Math::degrees_to_radians(angle)`
- `PerfectShape::Math::radians_to_degrees(angle)`
- `PerfectShape::Line`
- `PerfectShape::Line::relative_ccw(x1, y1, x2, y2, px, py)`
- `PerfectShape::Arc`
- `PerfectShape::Arc#contain?(x_or_point, y=nil)`
