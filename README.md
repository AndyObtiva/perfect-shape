# Perfect Shape 0.0.1
## Geometric Algorithms

`PerfectShape` is a collection of pure Ruby geometric algorithms that are mostly useful for GUI (Graphical User Interface) manipulation like checking containment of a point in popular geometric shapes such as rectangle, square, arc, circle, polygon, polyline, and paths containing lines, bezier curves, and quadratic curves.

Additionally, `PerfectShape::Math` contains some purely mathematical algorithms.

To ensure high accuracy, this library does all its mathematical operations with `BigDecimal` numbers.

## Setup

Run:

```
gem install perfect-shape -v 0.0.1
```

Or include in Bundler `Gemfile`:

```ruby
gem 'perfect-shape', '~> 0.0.1'
```

And, run:

```
bundle
```

## API

### `PerfectShape::Math`

- `::degrees_to_radians(angle)`
- `::radians_to_degrees(angle)`
- `::ieee_remainder(x, y)` (alias: `ieee754_remainder`)

### `PerfectShape::Line`

- `::relative_ccw(x1, y1, x2, y2, px, py)`: Returns an indicator of where the specified point px,py lies with respect to the line segment from x1,y1 to x2,y2

### `PerfectShape::Arc`

- `::new(type: :open, x: 0, y: 0, width: 1, height: 1, start: 0, extent: 360)`: constructs an arc of type  `:open` (default), `:chord`, or `:pie`
- `#x`: top-left x of arc
- `#y`: top-left y of arc
- `#width`: width of arc
- `#height`: height of arc
- `#start`: start angle in degrees
- `#extent`: extent angle in degrees
- `#contain?(x_or_point, y=0)`: checks if point is in arc

## TODO

[TODO.md](TODO.md)

## Change Log

[CHANGELOG.md](CHANGELOG.md)

## Contributing to perfect-shape

-   Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
-   Check out the issue tracker to make sure someone already hasn't
    requested it and/or contributed it.
-   Fork the project.
-   Start a feature/bugfix branch.
-   Commit and push until you are happy with your contribution.
-   Make sure to add tests for it. This is important so I don't break it
    in a future version unintentionally.
-   Please try not to mess with the Rakefile, version, or history. If
    you want to have your own version, or is otherwise necessary, that
    is fine, but please isolate to its own commit so I can cherry-pick
    around it.

## Copyright

[MIT](LICENSE.txt)

Copyright (c) 2021 Andy Maleh. See
[LICENSE.txt](LICENSE.txt) for further details.
