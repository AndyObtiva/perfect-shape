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
  end
end
