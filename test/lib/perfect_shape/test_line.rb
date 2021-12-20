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

    it 'contains point in center' do
      shape = PerfectShape::Line.new(points: [[0, 0], [100, 100]])
      point = [shape.center_x, shape.center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
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
    end
    
    it 'contains point with distance tolerance' do
      shape = PerfectShape::Line.new(points: [[0, 0], [100, 100]])
      point = [50, 50.01]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(point, distance: 0.01)).must_equal true
      _(shape.contain?(point, distance: 0.001)).must_equal false
      
      shape = PerfectShape::Line.new(points: [[0, 0], [0, 100]])
      point = [1, 0]

      _(shape.contain?(point)).must_equal false
      _(shape.contain?(point, distance: 1)).must_equal true
      _(shape.contain?(point, distance: 0.9)).must_equal false
    end
    
    it 'returns point segment distance' do
      shape = PerfectShape::Line.new(points: [[0, 0], [100, 0]])
      point = [0, 1]

      _(shape.point_segment_distance(point)).must_equal 1
      _(shape.point_segment_distance(point)).must_equal shape.point_segment_distance(*point)
      
      point = [0, 2]

      _(shape.point_segment_distance(point)).must_equal 2
      _(shape.point_segment_distance(point)).must_equal shape.point_segment_distance(*point)
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
  end
end