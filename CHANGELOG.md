# Change Log

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
