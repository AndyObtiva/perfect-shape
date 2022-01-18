require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Line do
    it 'constructs with points' do
      shape = PerfectShape::Line.new(points: [[200, 150], [270, 170]])

      _(shape.points).must_equal [[200, 150], [270, 170]]
      _(shape.min_x).must_equal 200
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 170
      _(shape.width).must_equal 70
      _(shape.height).must_equal 20
      _(shape.center_x).must_equal 200 + 35
      _(shape.center_y).must_equal 150 + 10
    end

    it 'constructs with flattened points' do
      shape = PerfectShape::Line.new(points: [200, 150, 270, 170])

      _(shape.points).must_equal [[200, 150], [270, 170]]
      _(shape.min_x).must_equal 200
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 170
      _(shape.width).must_equal 70
      _(shape.height).must_equal 20
      _(shape.center_x).must_equal 200 + 35
      _(shape.center_y).must_equal 150 + 10
    end

    it 'constructs with defaults' do
      shape = PerfectShape::Line.new

      _(shape.points).must_equal []
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
      shape = PerfectShape::Line.new
      shape.points = [[200, 150], [270, 170]]

      _(shape.points).must_equal [[200, 150], [270, 170]]
      _(shape.min_x).must_equal 200
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 170
      _(shape.width).must_equal 70
      _(shape.height).must_equal 20
      _(shape.center_x).must_equal 200 + 35
      _(shape.center_y).must_equal 150 + 10
    end
    
    it 'equals another line' do
      shape = PerfectShape::Line.new(points: [[200, 150], [270, 170]])
      shape2 = PerfectShape::Line.new(points: [[200, 150], [270, 170]])

      _(shape).must_equal shape2
    end

    it 'does not equal a different line' do
      shape = PerfectShape::Line.new(points: [[200, 150], [270, 170]])
      shape2 = PerfectShape::Line.new(points: [[201, 150], [270, 170]])

      _(shape).wont_equal shape2
      
      shape3 = PerfectShape::Line.new(points: [[200, 151], [270, 170]])

      _(shape).wont_equal shape3
    end
    
    it 'contains point in center' do
      shape = PerfectShape::Line.new(points: [[0, 0], [100, 100]])
      point = [shape.center_x, shape.center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
      _(shape.contain?(point)).must_equal shape.contain?(point, outline: true)
    end

    it 'contains point at end' do
      shape = PerfectShape::Line.new(points: [[0, 0], [100, 100]])
      point = [0, 0]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point at other end' do
      shape = PerfectShape::Line.new(points: [[0, 0], [100, 100]])
      point = [100, 100]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point' do
      shape = PerfectShape::Line.new(points: [[0, 0], [100, 100]])
      point = [50, 50.01]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(point, outline: true)).must_equal false
    end
    
    it 'contains point with distance tolerance' do
      shape = PerfectShape::Line.new(points: [[0, 0], [100, 100]])
      point = [50, 50.01]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(point, distance_tolerance: 0.01)).must_equal true
      _(shape.contain?(point, distance_tolerance: 0.001)).must_equal false
      
      shape = PerfectShape::Line.new(points: [[0, 0], [0, 100]])
      point = [1, 0]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(point, distance_tolerance: 1)).must_equal true
      _(shape.contain?(point, distance_tolerance: 0.9)).must_equal false
    end
    
    it 'returns point segment distance' do
      shape = PerfectShape::Line.new(points: [[0, 0], [100, 0]])
      point = [0, 1]

      _(shape.point_distance(point)).must_equal 1
      _(shape.point_distance(point)).must_equal shape.point_distance(*point)
      
      point = [0, 2]

      _(shape.point_distance(point)).must_equal 2
      _(shape.point_distance(point)).must_equal shape.point_distance(*point)
    end
    
    it 'returns relative counter clockwise value of point' do
      shape = PerfectShape::Line.new(points: [[0, 0], [100, 100]])
      point = [50, 50]

      _(shape.relative_counterclockwise(point)).must_equal 0
      _(shape.relative_counterclockwise(point)).must_equal shape.relative_counterclockwise(*point)
      
      point = [55, 50]

      _(shape.relative_counterclockwise(point)).must_equal 1
      _(shape.relative_counterclockwise(point)).must_equal shape.relative_counterclockwise(*point)
      
      point = [45, 50]

      _(shape.relative_counterclockwise(point)).must_equal -1
      _(shape.relative_counterclockwise(point)).must_equal shape.relative_counterclockwise(*point)
    end
    
    it 'intersects rectangle on left edge' do
      shape = PerfectShape::Line.new(points: [[0, 33], [4, 33]])
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      
      assert shape.intersect?(rectangle)
    end
    
    it 'intersects rectangle on top-left corner' do
      shape = PerfectShape::Line.new(points: [[1, 2], [3, 4]])
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      
      assert shape.intersect?(rectangle)
    end
    
    it 'intersects rectangle by lying inside it' do
      shape = PerfectShape::Line.new(points: [[5, 33], [6, 33]])
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      
      assert shape.intersect?(rectangle)
    end

    it 'does not intersect line' do
      shape = PerfectShape::Line.new(points: [[-1, 33], [-1, 33]])
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      
      refute shape.intersect?(rectangle)
    end
    
  end
end
