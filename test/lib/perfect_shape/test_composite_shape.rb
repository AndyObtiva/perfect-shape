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
  end
end
