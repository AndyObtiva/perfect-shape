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

    it 'intersects rectangle' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      rectangle = PerfectShape::Rectangle.new(x: 0, y: 0, width: 50, height: 60)

      assert shape.intersect?(rectangle)
    end

    it 'intersects rectangle by lying inside it' do
      shape = PerfectShape::Rectangle.new(x: 5, y: 6, width: 40, height: 50)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)

      assert shape.intersect?(rectangle)
    end

    it 'intersects rectangle by completely containing it' do
      shape = PerfectShape::Rectangle.new(x: 0, y: 0, width: 60, height: 70)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)

      assert shape.intersect?(rectangle)
    end

    it 'intersects rectangle by matching it perfectly' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)

      assert shape.intersect?(rectangle)
    end

    it 'does not intersect rectangle' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      rectangle = PerfectShape::Rectangle.new(x: 55, y: 65, width: 50, height: 60)

      refute shape.intersect?(rectangle)
    end
    
    it 'returns 5 path shapes as a rectangle with positive width and height' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      path_shapes = shape.to_path_shapes

      _(path_shapes.count).must_equal 5
      _(path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::Line, PerfectShape::Line, PerfectShape::Line, PerfectShape::Line]

      _(path_shapes[0].x).must_equal 2
      _(path_shapes[0].y).must_equal 3

      _(path_shapes[1].points[0][0].to_i).must_equal 2 + 50
      _(path_shapes[1].points[0][1].to_i).must_equal 3

      _(path_shapes[2].points[0][0].to_i).must_equal 2 + 50
      _(path_shapes[2].points[0][1].to_i).must_equal 3 + 60

      _(path_shapes[3].points[0][0].to_i).must_equal 2
      _(path_shapes[3].points[0][1].to_i).must_equal 3 + 60

      _(path_shapes[4].points[0][0].to_i).must_equal 2
      _(path_shapes[4].points[0][1].to_i).must_equal 3
    end
    
    it 'returns 3 path shapes as a rectangle with 0 width and positive height' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 0, height: 60)
      path_shapes = shape.to_path_shapes

      _(path_shapes.count).must_equal 3
      _(path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::Line, PerfectShape::Line]

      _(path_shapes[0].x).must_equal 2
      _(path_shapes[0].y).must_equal 3

      _(path_shapes[1].points[0][0].to_i).must_equal 2
      _(path_shapes[1].points[0][1].to_i).must_equal 3 + 60

      _(path_shapes[2].points[0][0].to_i).must_equal 2
      _(path_shapes[2].points[0][1].to_i).must_equal 3
    end
    
    it 'returns 3 path shapes as a rectangle with positive width and 0 height' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 0)
      path_shapes = shape.to_path_shapes

      _(path_shapes.count).must_equal 3
      _(path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::Line, PerfectShape::Line]

      _(path_shapes[0].x).must_equal 2
      _(path_shapes[0].y).must_equal 3

      _(path_shapes[1].points[0][0].to_i).must_equal 2 + 50
      _(path_shapes[1].points[0][1].to_i).must_equal 3

      _(path_shapes[2].points[0][0].to_i).must_equal 2
      _(path_shapes[2].points[0][1].to_i).must_equal 3
    end
    
    
    it 'returns 2 path shapes as a rectangle with 0 width and 0 height' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 0, height: 0)
      path_shapes = shape.to_path_shapes

      _(path_shapes.count).must_equal 2
      _(path_shapes.map(&:class)).must_equal [PerfectShape::Point, PerfectShape::Line]

      _(path_shapes[0].x).must_equal 2
      _(path_shapes[0].y).must_equal 3

      _(path_shapes[1].points[0][0].to_i).must_equal 2
      _(path_shapes[1].points[0][1].to_i).must_equal 3
    end
    
    it 'returns 0 path shapes as a rectangle with negative width and positive height' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: -50, height: 60)
      path_shapes = shape.to_path_shapes

      _(path_shapes.count).must_equal 0
    end

    it 'returns 0 path shapes as a rectangle with positive width and negative height' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: -60)
      path_shapes = shape.to_path_shapes

      _(path_shapes.count).must_equal 0
    end

    it 'returns 0 path shapes as a rectangle with negative width and negative height' do
      shape = PerfectShape::Rectangle.new(x: 2, y: 3, width: -50, height: -60)
      path_shapes = shape.to_path_shapes

      _(path_shapes.count).must_equal 0
    end
  end
end
