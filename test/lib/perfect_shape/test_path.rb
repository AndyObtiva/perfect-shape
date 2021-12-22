require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Path do
    it 'constructs as closed with :wind_non_zero winding rule and shapes consisting of lines having single (end) point only' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: true, winding_rule: :wind_non_zero)

      _(shape.shapes).must_equal path_shapes
      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [200, 150]]
      _(shape.drawing_types).must_equal [:move_to, :line_to, :line_to, :line_to, :line_to, :line_to, :close]
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

    it 'constructs as open with :wind_even_odd winding rule and shapes consisting of lines having single (end) point only' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

      shape = PerfectShape::Path.new(shapes: path_shapes, closed: false, winding_rule: :wind_even_odd)

      _(shape.shapes).must_equal path_shapes
      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
      _(shape.drawing_types).must_equal [:move_to, :line_to, :line_to, :line_to, :line_to, :line_to]
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
      _(shape.winding_rule).must_equal :wind_non_zero
      _(shape.closed).must_equal false
      _(shape.closed?).must_equal false
      _(shape.min_x).must_equal nil
      _(shape.min_y).must_equal nil
      _(shape.max_x).must_equal nil
      _(shape.max_y).must_equal nil
      _(shape.width).must_equal nil
      _(shape.height).must_equal nil
      _(shape.center_x).must_equal nil
      _(shape.center_y).must_equal nil
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
      
      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170], [200, 150]]
      _(shape.drawing_types).must_equal [:move_to, :line_to, :line_to, :line_to, :line_to, :line_to, :close]
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
      
      proc { shape.winding_rule = :invalid }.must_raise StandardError
    end

    it 'does not set invalid winding rule' do
      shape = PerfectShape::Path.new
      
      proc { shape.points = [[1, 2]] }.must_raise StandardError
    end

    it 'equals other path' do
      path_shapes = []
      path_shapes << PerfectShape::Point.new(x: 200, y: 150)
      path_shapes << PerfectShape::Line.new(points: [270, 170])
      path_shapes << PerfectShape::Line.new(points: [250, 220])
      path_shapes << PerfectShape::Line.new(points: [220, 190])
      path_shapes << PerfectShape::Line.new(points: [200, 200])
      path_shapes << PerfectShape::Line.new(points: [180, 170])

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
    
    it 'contains point in center as closed using non-zero rule' do
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

    it 'contains point near edge as closed using non-zero rule' do
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

    it 'contains point near corner as closed using non-zero rule' do
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

    it 'does not contain point within bounding box as closed using non-zero rule' do
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

    it 'does not contain point outside of bounding box as closed using non-zero rule' do
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

    it 'contains point in center as closed using even-odd rule' do
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

    it 'contains point near edge as closed using even-odd rule' do
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

    it 'contains point near corner as closed using even-odd rule' do
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

    it 'does not contain point within bounding box as closed using even-odd rule' do
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

    it 'does not contain point outside of bounding box as closed using even-odd rule' do
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
  end
end
