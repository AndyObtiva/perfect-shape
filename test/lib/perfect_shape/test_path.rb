require 'puts_debuggerer'
require 'minitest/autorun'
require 'minitest/focus'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Path do
    it 'constructs as closed with :wind_non_zero winding rule and shapes consisting of lines and bezier curves not having start point (not needed)' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[200, 150], [230, 160], [270, 220], [180, 170]])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)

      _(shape.shapes).must_equal path_shapes
      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [195, 185], [200, 190], [200, 150], [230, 160], [270, 220], [180, 170], [200, 150]]
      _(shape.drawing_types).must_equal [:move_to, :line_to, :line_to, :line_to, :line_to, :line_to, :quad_to, :cubic_to, :close]
      _(shape.winding_rule).must_equal :wind_non_zero
      _(shape.closed).must_equal true
      _(shape.closed?).must_equal true
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs as closed with :wind_non_zero winding rule and shapes consisting of first line having start point and other lines and bezier curves not having start point (not needed)' do
      path_shapes = []
      path_shapes << PerfectShape::Line.new(points: [[200, 150], [270, 170]])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[200, 150], [230, 160], [270, 220], [180, 170]])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)

      _(shape.shapes).must_equal path_shapes
      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [195, 185], [200, 190], [200, 150], [230, 160], [270, 220], [180, 170], [200, 150]]
      _(shape.drawing_types).must_equal [:move_to, :line_to, :line_to, :line_to, :line_to, :line_to, :quad_to, :cubic_to, :close]
      _(shape.winding_rule).must_equal :wind_non_zero
      _(shape.closed).must_equal true
      _(shape.closed?).must_equal true
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs as open with :wind_even_odd winding rule and shapes consisting of lines and bezier curves not having start point (not needed)' do
      path_shapes = []
      path_shapes << [200, 150]
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[230, 160], [270, 220], [180, 170]])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)

      _(shape.shapes).must_equal path_shapes
      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [195, 185], [200, 190], [230, 160], [270, 220], [180, 170]]
      _(shape.drawing_types).must_equal [:move_to, :line_to, :line_to, :line_to, :line_to, :line_to, :quad_to, :cubic_to]
      _(shape.winding_rule).must_equal :wind_even_odd
      _(shape.closed).must_equal false
      _(shape.closed?).must_equal false
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs as open with :wind_even_odd winding rule and shapes consisting of arcs, rectangles, lines and bezier curves not having start point (not needed)' do
      path_shapes = []
      path_shapes << [200, 150]
      path_shapes << PerfectShape::Arc.new(x: 200, y: 150, width: 20, height: 20, start: 0, extent: 360)
      path_shapes << PerfectShape::Rectangle.new(x: 235, y: 160, width: 30, height: 15)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[230, 160], [270, 220], [180, 170]])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)

      _(shape.shapes).must_equal path_shapes
      expected_points = [[200, 150]]
      expected_points += path_shapes[1].to_path_shapes.map {|shape| shape.respond_to?(:points) ? shape.points : [shape.to_a] }.reduce(:+)
      expected_points += path_shapes[2].to_path_shapes.map {|shape| shape.respond_to?(:points) ? shape.points : [shape.to_a] }.reduce(:+)
      expected_points += [[270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [195, 185], [200, 190], [230, 160], [270, 220], [180, 170]]
      _(shape.points).must_equal expected_points
      expected_drawing_types = [:move_to]
      expected_drawing_types += PerfectShape::Path.new(shapes: path_shapes[1].to_path_shapes).drawing_types
      expected_drawing_types += PerfectShape::Path.new(shapes: path_shapes[2].to_path_shapes).drawing_types
      expected_drawing_types += [:line_to, :line_to, :line_to, :line_to, :line_to, :quad_to, :cubic_to]
      _(shape.drawing_types).must_equal expected_drawing_types
      _(shape.drawing_types[1]).must_equal :move_to
      _(shape.winding_rule).must_equal :wind_even_odd
      _(shape.closed).must_equal false
      _(shape.closed?).must_equal false
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs as open with :wind_even_odd winding rule and shapes consisting of arcs, rectangles, lines and bezier curves not having start point (not needed)' do
      path_shapes = []
      path_shapes << [200, 150]
      path_shapes << PerfectShape::Arc.new(x: 200, y: 150, width: 20, height: 20, start: 0, extent: 360)
      path_shapes << PerfectShape::Rectangle.new(x: 235, y: 160, width: 30, height: 15)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[230, 160], [270, 220], [180, 170]])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd, line_to_complex_shapes: true)

      _(shape.shapes).must_equal path_shapes
      expected_points = [[200, 150]]
      expected_points += path_shapes[1].to_path_shapes.map {|shape| shape.respond_to?(:points) ? shape.points : [shape.to_a] }.reduce(:+)
      expected_points += path_shapes[2].to_path_shapes.map {|shape| shape.respond_to?(:points) ? shape.points : [shape.to_a] }.reduce(:+)
      expected_points += [[270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [195, 185], [200, 190], [230, 160], [270, 220], [180, 170]]
      _(shape.points).must_equal expected_points
      expected_drawing_types = [:move_to]
      expected_drawing_types += PerfectShape::Path.new(shapes: path_shapes[1].to_path_shapes, line_to_complex_shapes: true).drawing_types
      expected_drawing_types[1] = :line_to
      expected_drawing_types += PerfectShape::Path.new(shapes: path_shapes[2].to_path_shapes, line_to_complex_shapes: true).drawing_types
      expected_drawing_types[6] = :line_to
      expected_drawing_types += [:line_to, :line_to, :line_to, :line_to, :line_to, :quad_to, :cubic_to]
      _(shape.drawing_types).must_equal expected_drawing_types
      _(shape.drawing_types[1]).must_equal :line_to
      _(shape.winding_rule).must_equal :wind_even_odd
      _(shape.closed).must_equal false
      _(shape.closed?).must_equal false
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs as open with :wind_even_odd winding rule and shapes consisting of arc (containing first point), rectangles, lines and bezier curves not having start point (not needed)' do
      path_shapes = []
      path_shapes << PerfectShape::Arc.new(x: 200, y: 150, width: 20, height: 20, start: 0, extent: 360)
      path_shapes << PerfectShape::Rectangle.new(x: 235, y: 160, width: 30, height: 15)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[230, 160], [270, 220], [180, 170]])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd, line_to_complex_shapes: true)

      _(shape.shapes).must_equal path_shapes
      expected_points = [[200, 150]]
      expected_points += path_shapes[0].to_path_shapes.map {|shape| shape.respond_to?(:points) ? shape.points : [shape.to_a] }.reduce(:+)
      expected_points += path_shapes[1].to_path_shapes.map {|shape| shape.respond_to?(:points) ? shape.points : [shape.to_a] }.reduce(:+)
      expected_points += [[270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [195, 185], [200, 190], [230, 160], [270, 220], [180, 170]]
      _(shape.points).must_equal expected_points
      expected_drawing_types = [:move_to]
      expected_drawing_types += PerfectShape::Path.new(shapes: path_shapes[0].to_path_shapes, line_to_complex_shapes: true).drawing_types
      expected_drawing_types[1] = :line_to
      expected_drawing_types += PerfectShape::Path.new(shapes: path_shapes[1].to_path_shapes, line_to_complex_shapes: true).drawing_types
      expected_drawing_types[6] = :line_to
      expected_drawing_types += [:line_to, :line_to, :line_to, :line_to, :line_to, :quad_to, :cubic_to]
      _(shape.drawing_types).must_equal expected_drawing_types
      _(shape.drawing_types[1]).must_equal :line_to
      _(shape.winding_rule).must_equal :wind_even_odd
      _(shape.closed).must_equal false
      _(shape.closed?).must_equal false
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs as open with :wind_even_odd winding rule and shapes consisting of ellipses, lines and bezier curves not having start point (not needed)' do
      path_shapes = []
      path_shapes << [200, 150]
      path_shapes << PerfectShape::Ellipse.new(x: 200, y: 150, width: 20, height: 20)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[230, 160], [270, 220], [180, 170]])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)

      _(shape.shapes).must_equal path_shapes
      expected_points = [[200, 150]]
      expected_points += path_shapes[1].to_path_shapes.map {|shape| shape.respond_to?(:points) ? shape.points : [shape.to_a] }.reduce(:+)
      expected_points += [[270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [195, 185], [200, 190], [230, 160], [270, 220], [180, 170]]
      _(shape.points).must_equal expected_points
      expected_drawing_types = [:move_to]
      expected_drawing_types += PerfectShape::Path.new(shapes: path_shapes[1].to_path_shapes).drawing_types
      expected_drawing_types += [:line_to, :line_to, :line_to, :line_to, :line_to, :quad_to, :cubic_to]
      _(shape.drawing_types).must_equal expected_drawing_types
      _(shape.drawing_types[1]).must_equal :move_to
      _(shape.winding_rule).must_equal :wind_even_odd
      _(shape.closed).must_equal false
      _(shape.closed?).must_equal false
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs as open with :wind_even_odd winding rule and shapes consisting of ellipses, lines and bezier curves not having start point (not needed)' do
      path_shapes = []
      path_shapes << [200, 150]
      path_shapes << PerfectShape::Ellipse.new(x: 200, y: 150, width: 20, height: 20)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[230, 160], [270, 220], [180, 170]])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd, line_to_complex_shapes: true)

      _(shape.shapes).must_equal path_shapes
      expected_points = [[200, 150]]
      expected_points += path_shapes[1].to_path_shapes.map {|shape| shape.respond_to?(:points) ? shape.points : [shape.to_a] }.reduce(:+)
      expected_points += [[270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [195, 185], [200, 190], [230, 160], [270, 220], [180, 170]]
      _(shape.points).must_equal expected_points
      expected_drawing_types = [:move_to]
      expected_drawing_types += PerfectShape::Path.new(shapes: path_shapes[1].to_path_shapes, line_to_complex_shapes: true).drawing_types
      expected_drawing_types += [:line_to, :line_to, :line_to, :line_to, :line_to, :quad_to, :cubic_to]
      expected_drawing_types[1] = :line_to
      _(shape.drawing_types).must_equal expected_drawing_types
      _(shape.drawing_types[1]).must_equal :line_to
      _(shape.winding_rule).must_equal :wind_even_odd
      _(shape.closed).must_equal false
      _(shape.closed?).must_equal false
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs as open with :wind_even_odd winding rule and shapes consisting of circles, lines and bezier curves not having start point (not needed)' do
      path_shapes = []
      path_shapes << [200, 150]
      path_shapes << PerfectShape::Circle.new(x: 200, y: 150, diameter: 20)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[230, 160], [270, 220], [180, 170]])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)

      _(shape.shapes).must_equal path_shapes
      expected_points = [[200, 150]]
      expected_points += path_shapes[1].to_path_shapes.map {|shape| shape.respond_to?(:points) ? shape.points : [shape.to_a] }.reduce(:+)
      expected_points += [[270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [195, 185], [200, 190], [230, 160], [270, 220], [180, 170]]
      _(shape.points).must_equal expected_points
      expected_drawing_types = [:move_to]
      expected_drawing_types += PerfectShape::Path.new(shapes: path_shapes[1].to_path_shapes).drawing_types
      expected_drawing_types += [:line_to, :line_to, :line_to, :line_to, :line_to, :quad_to, :cubic_to]
      _(shape.drawing_types).must_equal expected_drawing_types
      _(shape.drawing_types[1]).must_equal :move_to
      _(shape.winding_rule).must_equal :wind_even_odd
      _(shape.closed).must_equal false
      _(shape.closed?).must_equal false
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs as open with :wind_even_odd winding rule and shapes consisting of circles, lines and bezier curves not having start point (not needed)' do
      path_shapes = []
      path_shapes << [200, 150]
      path_shapes << PerfectShape::Circle.new(x: 200, y: 150, diameter: 20)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[230, 160], [270, 220], [180, 170]])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd, line_to_complex_shapes: true)

      _(shape.shapes).must_equal path_shapes
      expected_points = [[200, 150]]
      expected_points += path_shapes[1].to_path_shapes.map {|shape| shape.respond_to?(:points) ? shape.points : [shape.to_a] }.reduce(:+)
      expected_points += [[270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [195, 185], [200, 190], [230, 160], [270, 220], [180, 170]]
      _(shape.points).must_equal expected_points
      expected_drawing_types = [:move_to]
      expected_drawing_types += PerfectShape::Path.new(shapes: path_shapes[1].to_path_shapes, line_to_complex_shapes: true).drawing_types
      expected_drawing_types += [:line_to, :line_to, :line_to, :line_to, :line_to, :quad_to, :cubic_to]
      expected_drawing_types[1] = :line_to
      _(shape.drawing_types).must_equal expected_drawing_types
      _(shape.drawing_types[1]).must_equal :line_to
      _(shape.winding_rule).must_equal :wind_even_odd
      _(shape.closed).must_equal false
      _(shape.closed?).must_equal false
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs with defaults' do
      shape = PerfectShape::Path.new

      _(shape.shapes).must_equal []
      _(shape.points).must_equal []
      _(shape.drawing_types).must_equal []
      _(shape.winding_rule).must_equal :wind_even_odd
      _(shape.closed).must_equal false
      _(shape.closed?).must_equal false
      assert_nil shape.min_x
      assert_nil shape.min_y
      assert_nil shape.max_x
      assert_nil shape.max_y
      assert_nil shape.width
      assert_nil shape.height
      assert_nil shape.center_x
      assert_nil shape.center_y
    end

    it 'updates attributes' do
      shape = PerfectShape::Path.new

      shape.closed = true
      shape.winding_rule = :wind_non_zero

      shape.shapes << PerfectShape::Point.new(x: 200, y: 150)
      shape.shapes << PerfectShape::Line.new(points: [270, 170])
      shape.shapes << PerfectShape::Line.new(points: [250, 220])
      shape.shapes << PerfectShape::Line.new(points: [220, 190])
      shape.shapes << PerfectShape::Line.new(points: [200, 200])
      shape.shapes << PerfectShape::Line.new(points: [180, 170])
      shape.shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      shape.shapes << PerfectShape::CubicBezierCurve.new(points: [[230, 160], [270, 220], [180, 170]])

      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [195, 185], [200, 190], [230, 160], [270, 220], [180, 170], [200, 150]]
      _(shape.drawing_types).must_equal [:move_to, :line_to, :line_to, :line_to, :line_to, :line_to, :quad_to, :cubic_to, :close]
      _(shape.winding_rule).must_equal :wind_non_zero
      _(shape.closed).must_equal true
      _(shape.closed?).must_equal true
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'does not set invalid winding rule' do
      shape = PerfectShape::Path.new

      _(proc { shape.winding_rule = :invalid }).must_raise StandardError
    end

    it 'does not set invalid winding rule' do
      shape = PerfectShape::Path.new

      _(proc { shape.points = [[1, 2]] }).must_raise StandardError
    end

    it 'equals other path' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[230, 160], [270, 220], [180, 170]])

      shape1 = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      shape2 = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)

      _(shape2).must_equal shape1
    end

    it 'does not equal different path' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[195, 185], [200, 190]])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[230, 160], [270, 220], [180, 170]])

      shape1 = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      path_shapes2 = path_shapes.dup
      path_shapes2.pop
      shape2 = PerfectShape::Path.new(shapes: path_shapes2, closed: true, winding_rule: :wind_non_zero)

      _(shape2).wont_equal shape1

      shape2 = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_non_zero)

      _(shape2).wont_equal shape1

      shape2 = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)

      _(shape2).wont_equal shape1
    end

    it 'contains point in center as closed line-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [shape.center_x, shape.center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point in center as closed line-based path using non-zero rule starting with line having first point' do
      path_shapes = []
      path_shapes << PerfectShape::Line.new(points: [[200, 150], [270, 170]])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [shape.center_x, shape.center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near edge as closed line-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [235, 161]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near corner as closed line-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [269, 170]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point within bounding box as closed line-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [235, 159]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside of bounding box as closed line-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [0, 0]

      _(shape.contain?(point)).must_equal false
    end

    it 'contains point in center as closed line-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [shape.center_x, shape.center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near edge as closed line-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [235, 161]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near corner as closed line-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [269, 170]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point within bounding box as closed line-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [235, 159]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside of bounding box as closed line-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [0, 0]

      _(shape.contain?(point)).must_equal false
    end

    it 'contains point in center as closed quadratic-bezier-curve-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [shape.center_x, shape.center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near edge as closed quadratic-bezier-curve-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [235, 161]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near corner as closed quadratic-bezier-curve-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [269, 170]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point within bounding box as closed quadratic-bezier-curve-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [235, 159]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside of bounding box as closed quadratic-bezier-curve-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [0, 0]

      _(shape.contain?(point)).must_equal false
    end

    it 'contains point in center as closed quadratic-bezier-curve-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [shape.center_x, shape.center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near edge as closed quadratic-bezier-curve-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [235, 161]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near corner as closed quadratic-bezier-curve-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [269, 170]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point within bounding box as closed quadratic-bezier-curve-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [235, 159]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside of bounding box as closed quadratic-bezier-curve-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200])
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [0, 0]

      _(shape.contain?(point)).must_equal false
    end

    it 'contains point in center as closed cubic-bezier-curve-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 210, 250, 220])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [shape.center_x, shape.center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near edge as closed cubic-bezier-curve-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 210, 250, 220])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [235, 161]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near corner as closed cubic-bezier-curve-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 210, 250, 220])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [269, 170]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point within bounding box as closed cubic-bezier-curve-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 210, 250, 220])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [235, 159]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside of bounding box as closed cubic-bezier-curve-based path using non-zero rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 210, 250, 220])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)
      point = [0, 0]

      _(shape.contain?(point)).must_equal false
    end

    it 'contains point in center as closed cubic-bezier-curve-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 210, 250, 220])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [shape.center_x, shape.center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near edge as closed cubic-bezier-curve-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 210, 250, 220])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [235, 161]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near corner as closed cubic-bezier-curve-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 210, 250, 220])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [269, 170]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point within bounding box as closed cubic-bezier-curve-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 210, 250, 220])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [235, 159]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside of bounding box as closed cubic-bezier-curve-based path using even-odd rule' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 210, 250, 220])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200])
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [0, 0]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point in center on outline' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)
      point = [shape.center_x, shape.center_y]

      refute shape.contain?(point, outline: true)
    end

    it 'does not contain point in center on outline without point in beginning' do
      path_shapes = []
      path_shapes << PerfectShape::Line.new(points: [[200, 150], [250, 170]]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)
      point = [shape.center_x, shape.center_y]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point element of path outline' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)
      point = [200, 150]

      assert shape.contain?(point, outline: true)
    end

    it 'contains point on line of path outline' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)
      point = shape.disconnected_shapes[0].center_point

      assert shape.contain?(point, outline: true)
    end

    it 'contains point on quadratic bezier curve of path outline' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)
      point = shape.disconnected_shapes[1].curve_center_point

      assert shape.contain?(point, outline: true)
    end

    it 'contains point on cubic bezier curve of path outline' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)
      point = shape.disconnected_shapes[2].curve_center_point

      assert shape.contain?(point, outline: true)
    end

    it 'contains point on last connecting line of closed path outline' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = shape.disconnected_shapes[3].center_point

      assert shape.contain?(point, outline: true)
    end

    it 'does not contain point on line of path outline' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [shape.disconnected_shapes[0].center_x + 1, shape.disconnected_shapes[0].center_y]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on line of path outline with distance_tolerance' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [shape.disconnected_shapes[0].center_x + 1, shape.disconnected_shapes[0].center_y]

      assert shape.contain?(point, outline: true, distance_tolerance: 1)
    end

    it 'does not contain point on quadratic bezier curve of path outline' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)
      point = [shape.disconnected_shapes[1].curve_center_x + 1, shape.disconnected_shapes[1].curve_center_y]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on quadratic bezier curve of path outline with distance tolerance' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)
      point = [shape.disconnected_shapes[1].curve_center_x + 1, shape.disconnected_shapes[1].curve_center_y]

      assert shape.contain?(point, outline: true, distance_tolerance: 1)
    end

    it 'does not contain point on cubic bezier curve of path outline' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)
      point = [shape.disconnected_shapes[2].curve_center_x + 1, shape.disconnected_shapes[2].curve_center_y]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on cubic bezier curve of path outline with distance tolerance' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)
      point = [shape.disconnected_shapes[2].curve_center_x + 1, shape.disconnected_shapes[2].curve_center_y]

      assert shape.contain?(point, outline: true, distance_tolerance: 1)
    end

    it 'does not contain point on last connecting line of closed path outline' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [shape.disconnected_shapes[3].center_x + 1, shape.disconnected_shapes[3].center_y]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on last connecting line of closed path outline with distance tolerance' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [250, 170]) # no need for start point, just end point
      path_shapes << PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]) # no need for start point, just control point and end point
      path_shapes << PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]) # no need for start point, just two control points and end point

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [shape.disconnected_shapes[3].center_x + 1, shape.disconnected_shapes[3].center_y]

      assert shape.contain?(point, outline: true, distance_tolerance: 1)
    end

    it 'contains point when shapes only consist of a rectangle (non-basic-shape)' do
      path_shapes = []
      path_shapes << PerfectShape::Rectangle.new(x: 235, y: 160, width: 30, height: 15)

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)
      point = [245, 170]

      assert shape.contain?(point)
    end

    it 'contains point when shapes only consist of a rectangle (non-basic-shape) for a closed path' do
      path_shapes = []
      path_shapes << PerfectShape::Rectangle.new(x: 235, y: 160, width: 30, height: 15)

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)
      point = [245, 170]

      assert shape.contain?(point)
    end

    it 'returns disconnected shapes for closed path' do
      path_shapes = [
        [190, 150], # ignored since it is overridden by next point
        PerfectShape::Point.new(x: 200, y: 150),
        PerfectShape::Line.new(points: [250, 170]),
        PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]),
        PerfectShape::Point.new(x: 351, y: 151), # ignored since it is overridden by next point
        [352, 152],
        PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]),
      ]

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)

      expected_disconnected_shapes = [
        PerfectShape::Line.new(points: [[200, 150], [250, 170]]),
        PerfectShape::QuadraticBezierCurve.new(points: [[250, 170], [300, 185], [350, 150]]),
        PerfectShape::CubicBezierCurve.new(points: [[352, 152], [370, 50], [430, 220], [480, 170]]),
        PerfectShape::Line.new(points: [[480, 170], [190, 150]]),
      ]

      _(shape.disconnected_shapes.count).must_equal expected_disconnected_shapes.count
      _(shape.disconnected_shapes).must_equal expected_disconnected_shapes
    end

    it 'returns disconnected shapes for closed path ending with a point' do
      path_shapes = [
        [190, 150], # ignored since it is overridden by next point
        PerfectShape::Point.new(x: 200, y: 150),
        PerfectShape::Line.new(points: [250, 170]),
        PerfectShape::QuadraticBezierCurve.new(points: [[300, 185], [350, 150]]),
        PerfectShape::Point.new(x: 351, y: 151), # ignored since it is overridden by next point
        [352, 152],
        PerfectShape::CubicBezierCurve.new(points: [[370, 50], [430, 220], [480, 170]]),
        [400, 300],
      ]

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_even_odd)

      expected_disconnected_shapes = [
        PerfectShape::Line.new(points: [[200, 150], [250, 170]]),
        PerfectShape::QuadraticBezierCurve.new(points: [[250, 170], [300, 185], [350, 150]]),
        PerfectShape::CubicBezierCurve.new(points: [[352, 152], [370, 50], [430, 220], [480, 170]]),
        PerfectShape::Line.new(points: [[400, 300], [190, 150]]),
      ]

      _(shape.disconnected_shapes.count).must_equal expected_disconnected_shapes.count
      _(shape.disconnected_shapes).must_equal expected_disconnected_shapes
    end

    it 'intersects with rectangle as a path of lines' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::Line.new(points: [270, 170]),
        PerfectShape::Line.new(points: [250, 220]),
        PerfectShape::Line.new(points: [220, 190]),
        PerfectShape::Line.new(points: [200, 200]),
        PerfectShape::Line.new(points: [180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 180, y: 140, width: 50, height: 40)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by lying within it as a path of lines' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::Line.new(points: [270, 170]),
        PerfectShape::Line.new(points: [250, 220]),
        PerfectShape::Line.new(points: [220, 190]),
        PerfectShape::Line.new(points: [200, 200]),
        PerfectShape::Line.new(points: [180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 170, y: 140, width: 120, height: 90)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by containing it as a path of lines' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::Line.new(points: [270, 170]),
        PerfectShape::Line.new(points: [250, 220]),
        PerfectShape::Line.new(points: [220, 190]),
        PerfectShape::Line.new(points: [200, 200]),
        PerfectShape::Line.new(points: [180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 200, y: 160, width: 15, height: 20)

      assert shape.intersect?(rectangle)
    end

    it 'does not intersect with rectangle as a path of lines' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::Line.new(points: [270, 170]),
        PerfectShape::Line.new(points: [250, 220]),
        PerfectShape::Line.new(points: [220, 190]),
        PerfectShape::Line.new(points: [200, 200]),
        PerfectShape::Line.new(points: [180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 0, y: 0, width: 30, height: 20)

      refute shape.intersect?(rectangle)
    end

    it 'intersects with rectangle as a path of quads' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170]),
        PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220]),
        PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190]),
        PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200]),
        PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 180, y: 140, width: 50, height: 40)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by lying within it as a path of quads' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170]),
        PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220]),
        PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190]),
        PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200]),
        PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 170, y: 140, width: 120, height: 90)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by containing it as a path of quads' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170]),
        PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220]),
        PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190]),
        PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200]),
        PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 200, y: 160, width: 15, height: 20)

      assert shape.intersect?(rectangle)
    end

    it 'does not intersect with rectangle as a path of quads' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::QuadraticBezierCurve.new(points: [235, 160, 270, 170]),
        PerfectShape::QuadraticBezierCurve.new(points: [260, 195, 250, 220]),
        PerfectShape::QuadraticBezierCurve.new(points: [235, 205, 220, 190]),
        PerfectShape::QuadraticBezierCurve.new(points: [210, 195, 200, 200]),
        PerfectShape::QuadraticBezierCurve.new(points: [190, 185, 180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 0, y: 0, width: 30, height: 20)

      refute shape.intersect?(rectangle)
    end

    it 'intersects with rectangle as a path of cubics' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170]),
        PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 205, 250, 220]),
        PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190]),
        PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200]),
        PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 180, y: 140, width: 50, height: 40)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by lying within it as a path of cubics' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170]),
        PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 205, 250, 220]),
        PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190]),
        PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200]),
        PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 170, y: 140, width: 120, height: 90)

      assert shape.intersect?(rectangle)
    end

    it 'intersects with rectangle by containing it as a path of cubics' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170]),
        PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 205, 250, 220]),
        PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190]),
        PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200]),
        PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 200, y: 160, width: 15, height: 20)

      assert shape.intersect?(rectangle)
    end

    it 'does not intersect with rectangle as a path of cubics' do
      shapes = [
        PerfectShape::Point.new(200, 150),
        PerfectShape::CubicBezierCurve.new(points: [235, 160, 250, 165, 270, 170]),
        PerfectShape::CubicBezierCurve.new(points: [260, 195, 255, 205, 250, 220]),
        PerfectShape::CubicBezierCurve.new(points: [235, 205, 227, 197, 220, 190]),
        PerfectShape::CubicBezierCurve.new(points: [210, 195, 205, 197, 200, 200]),
        PerfectShape::CubicBezierCurve.new(points: [190, 185, 185, 177, 180, 170]),
      ]
      shape = PerfectShape::Path.new(shapes: shapes, closed: true)
      rectangle = PerfectShape::Rectangle.new(x: 0, y: 0, width: 30, height: 20)

      refute shape.intersect?(rectangle)
    end
  end
end
