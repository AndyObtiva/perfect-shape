require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::CompositeShape do
    it 'constructs from multiple shapes' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)

      _(shape.shapes).must_equal shapes
      _(shape.min_x).must_equal 20
      _(shape.min_y).must_equal 15
      _(shape.max_x).must_equal 120 + 100
      _(shape.max_y).must_equal 115 + 100
      _(shape.width).must_equal 120 + 100 - 20
      _(shape.height).must_equal 115 + 100 - 15
      _(shape.center_x).must_equal 20 + (120 + 100 - 20) / 2.0
      _(shape.center_y).must_equal 15 + (115 + 100 - 15) / 2.0
    end

    it 'constructs with defaults' do
      shape = PerfectShape::CompositeShape.new

      _(shape.shapes).must_equal []
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
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new
      shape.shapes = shapes

      _(shape.shapes).must_equal shapes
      _(shape.min_x).must_equal 20
      _(shape.min_y).must_equal 15
      _(shape.max_x).must_equal 120 + 100
      _(shape.max_y).must_equal 115 + 100
      _(shape.width).must_equal 120 + 100 - 20
      _(shape.height).must_equal 115 + 100 - 15
      _(shape.center_x).must_equal 20 + (120 + 100 - 20) / 2.0
      _(shape.center_y).must_equal 15 + (115 + 100 - 15) / 2.0
    end

    it 'equals other composite shape' do
      shapes1 = []
      shapes1 << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes1 << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)
      shapes2 = []
      shapes2 << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes2 << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape1 = PerfectShape::CompositeShape.new(shapes: shapes1)
      shape2 = PerfectShape::CompositeShape.new(shapes: shapes2)

      _(shape2).must_equal shape1
    end

    it 'does not equal different composite shape' do
      shapes1 = []
      shapes1 << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes1 << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)
      shapes2 = []
      shapes2 << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)
      shapes2 << PerfectShape::Square.new(x: 20, y: 15, length: 100)

      shape1 = PerfectShape::CompositeShape.new(shapes: shapes1)
      shape2 = PerfectShape::CompositeShape.new(shapes: shapes2)

      _(shape2).wont_equal shape1
    end

    it 'contains point in center of square shape' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = [shapes[0].center_x, shapes[0].center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point in center of circle shape' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = [shapes[1].center_x, shapes[1].center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point between square and circle' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = [121, 116]

      _(shape).wont_be :contain?, point
    end

    it 'does not contain point outside of bounding boxes of square and circle' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = [-1, -1]

      _(shape).wont_be :contain?, point
    end

    it 'does not contain center point of square shape in outline' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = [shapes[0].center_x, shapes[0].center_y]

      refute shape.contain?(point, outline: true)
    end

    it 'contains point on edge of square shape in outline' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = shapes[0].edges[0].center_point

      assert shape.contain?(point, outline: true)
    end
    
    it 'does not contain point near edge of square shape in outline' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = shapes[0].edges[0].center_point

      refute shape.contain?(point[0], point[1] + 1, outline: true)
    end
    
    it 'contains point near edge of square shape in outline with distance tolerance' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = shapes[0].edges[0].center_point

      assert shape.contain?(point[0], point[1] + 1, outline: true, distance_tolerance: 1)
    end
    
    it 'does not contain center point of circle shape in outline' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = [shapes[1].center_x, shapes[1].center_y]

      refute shape.contain?(point, outline: true)
    end
    
    it 'contains edge point of circle shape in outline' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = [shapes[1].x, shapes[1].center_y]

      assert shape.contain?(point, outline: true)
    end
    
    it 'does not contain point near edge of circle shape in outline' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = [shapes[1].x - 1, shapes[1].center_y]

      refute shape.contain?(point, outline: true)
    end
    
    it 'contains point near edge of circle shape in outline with distance tolerance' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 120, y: 115, diameter: 100)

      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      point = [shapes[1].x - 1, shapes[1].center_y]

      assert shape.contain?(point, outline: true, distance_tolerance: 1)
    end
    
    it 'intersects with rectangle via owned square' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 220, y: 215, diameter: 50)
      
      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      rectangle = PerfectShape::Rectangle.new(x: 0, y: 0, width: 60, height: 40)

      assert shape.intersect?(rectangle)
    end
    
    it 'intersects with rectangle via owned circle' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 220, y: 215, diameter: 50)
      
      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      rectangle = PerfectShape::Rectangle.new(x: 170, y: 170, width: 120, height: 100)

      assert shape.intersect?(rectangle)
    end
    
    it 'does not intersect with rectangle (between owned square and circle)' do
      shapes = []
      shapes << PerfectShape::Square.new(x: 20, y: 15, length: 100)
      shapes << PerfectShape::Circle.new(x: 220, y: 215, diameter: 50)
      
      shape = PerfectShape::CompositeShape.new(shapes: shapes)
      rectangle = PerfectShape::Rectangle.new(x: 130, y: 130, width: 40, height: 30)
      
      refute shape.intersect?(rectangle)
    end
  end
end
