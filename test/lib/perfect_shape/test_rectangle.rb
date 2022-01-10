require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Rectangle do
    it 'constructs with dimensions' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)

      _(shape.x).must_equal 2
      _(shape.y).must_equal 3
      _(shape.width).must_equal 50
      _(shape.height).must_equal 60
      _(shape.min_x).must_equal 2
      _(shape.min_y).must_equal 3
      _(shape.max_x).must_equal 2 + 50
      _(shape.max_y).must_equal 3 + 60
      _(shape.center_x).must_equal 2 + 25
      _(shape.center_y).must_equal 3 + 30
      _(shape.bounding_box).must_equal PerfectShape::Rectangle.new(x: shape.min_x, y: shape.min_y, width: shape.width, height: shape.height)
    end

    it 'constructs with defaults' do
      shape = PerfectShape::Rectangle.new

      _(shape.x).must_equal 0
      _(shape.y).must_equal 0
      _(shape.width).must_equal 1
      _(shape.height).must_equal 1
      _(shape.center_x).must_equal 0.5
      _(shape.center_y).must_equal 0.5
    end

    it 'updates attributes' do
      shape = PerfectShape::Rectangle.new
      shape.x = 2
      shape.y = 3
      shape.width = 50
      shape.height = 60

      _(shape.x).must_equal 2
      _(shape.y).must_equal 3
      _(shape.width).must_equal 50
      _(shape.height).must_equal 60
      _(shape.center_x).must_equal 2 + 25
      _(shape.center_y).must_equal 3 + 30
    end

    it 'equals another rectangle' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      shape2 = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)

      _(shape).must_equal shape2
    end

    it 'does not equal a different rectangle' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      shape2 = PerfectShape::Rectangle.new(x: 3, y: 3, width: 50, height: 60)

      _(shape).wont_equal shape2
    end

    it 'contains point at the top-left corner' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2, 3]

      _(shape).must_be :contain?, point
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'contains point at the outline top-left corner' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2, 3]

      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'contains point at the top-right corner' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50, 3]

      _(shape).must_be :contain?, point
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'contains point at the outline top-right corner' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50, 3]

      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'contains point at the bottom-left corner' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2, 3 + 60]

      _(shape).must_be :contain?, point
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'contains point at the outline bottom-left corner' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2, 3 + 60]

      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'contains point at the bottom-right corner' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50, 3 + 60]

      _(shape).must_be :contain?, point
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'contains point at the outline bottom-right corner' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50, 3 + 60]

      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'contains point at the top side' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3]

      _(shape).must_be :contain?, point
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'contains point at the outline top side' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3]

      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'contains point at the left side' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2, 3 + 30]

      _(shape).must_be :contain?, point
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'contains point at the outline left side' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2, 3 + 30]

      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'contains point at the right side' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50, 3 + 30]

      _(shape).must_be :contain?, point
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'contains point at the outline right side' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50, 3 + 30]

      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'contains point at the bottom side' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3 + 60]

      _(shape).must_be :contain?, point
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'contains point at the outline bottom side' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3 + 60]

      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'contains point inside shape' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3 + 30]

      _(shape).must_be :contain?, point
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'does not contain point inside shape when checking against outline only' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3 + 30]

      _(shape.contain?(point, outline: true)).must_equal false
    end

    it 'contains point inside shape when checking against outline having distance tolerance' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 2, 3 + 2]

      _(shape.contain?(point, outline: true, distance_tolerance: 2)).must_equal true
    end

    it 'does not contain point to the top-left of the shape' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 - 1, 3 - 1]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'does not contain point to the top of the shape' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3 - 1]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'does not contain point to the top-right of the shape' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50 + 1, 3 - 1]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'does not contain point to the right of the shape' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50 + 1, 3 + 30]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'does not contain point to the bottom-right of the shape' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 50 + 1, 3 + 30 + 1]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'does not contain point to the bottom of the shape' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 + 25, 3 + 60 + 1]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'does not contain point to the bottom-left of the shape' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 - 1, 3 + 60 + 1]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end

    it 'does not contain point to the left of the shape' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      point = [2 - 1, 3 + 30]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(*point)).must_equal shape.contain?(point)
    end
    
    it 'returns edges of rectangle' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      
      expected_edges = [
        PerfectShape::Line.new(points: [[2, 3], [2 + 50, 3]]),
        PerfectShape::Line.new(points: [[2 + 50, 3], [2 + 50, 3 + 60]]),
        PerfectShape::Line.new(points: [[2 + 50, 3 + 60], [2, 3 + 60]]),
        PerfectShape::Line.new(points: [[2, 3 + 60], [2, 3]]),
      ]
      
      _(shape.edges).must_equal expected_edges
    end
  end
end
