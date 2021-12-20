require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Point do
    it 'constructs with x, y coordinates' do
      shape = PerfectShape::Point.new(x: 200, y: 150)

      _(shape.x).must_equal 200
      _(shape.y).must_equal 150
      _(shape.min_x).must_equal 200
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 200
      _(shape.max_y).must_equal 150
      _(shape.width).must_equal 0
      _(shape.height).must_equal 0
      _(shape.center_x).must_equal 200
      _(shape.center_y).must_equal 150
    end

    it 'constructs with x, y coordinates' do
      shape = PerfectShape::Point.new(200, 150)

      _(shape.x).must_equal 200
      _(shape.y).must_equal 150
      _(shape.min_x).must_equal 200
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 200
      _(shape.max_y).must_equal 150
      _(shape.width).must_equal 0
      _(shape.height).must_equal 0
      _(shape.center_x).must_equal 200
      _(shape.center_y).must_equal 150
    end

    it 'constructs with point array' do
      shape = PerfectShape::Point.new([200, 150])

      _(shape.x).must_equal 200
      _(shape.y).must_equal 150
      _(shape.min_x).must_equal 200
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 200
      _(shape.max_y).must_equal 150
      _(shape.width).must_equal 0
      _(shape.height).must_equal 0
      _(shape.center_x).must_equal 200
      _(shape.center_y).must_equal 150
    end

    it 'constructs with defaults' do
      shape = PerfectShape::Point.new

      _(shape.x).must_equal 0
      _(shape.y).must_equal 0
      _(shape.min_x).must_equal 0
      _(shape.min_y).must_equal 0
      _(shape.max_x).must_equal 0
      _(shape.max_y).must_equal 0
      _(shape.width).must_equal 0
      _(shape.height).must_equal 0
      _(shape.center_x).must_equal 0
      _(shape.center_y).must_equal 0
    end

    it 'updates attributes' do
      shape = PerfectShape::Point.new
      shape.x = 200
      shape.y = 150

      _(shape.x).must_equal 200
      _(shape.y).must_equal 150
      _(shape.min_x).must_equal 200
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 200
      _(shape.max_y).must_equal 150
      _(shape.width).must_equal 0
      _(shape.height).must_equal 0
      _(shape.center_x).must_equal 200
      _(shape.center_y).must_equal 150
    end

    it 'returns distance from other point' do
      shape = PerfectShape::Point.new(200, 0)
      point = [200, 1]

      _(shape.point_distance(point)).must_equal 1
      _(shape.point_distance(point)).must_equal shape.point_distance(*point)
      
      point = [200, 2]

      _(shape.point_distance(point)).must_equal 2
      
      point = [202, 0]

      _(shape.point_distance(point)).must_equal 2
      
      point = [200, 0]

      _(shape.point_distance(point)).must_equal 0
    end
    
    it 'contains point' do
      shape = PerfectShape::Point.new(200, 100)
      
      point = [200, 100]
      
      _(shape.contain?(point)).must_equal true
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end
    
    it 'does not contain point' do
      shape = PerfectShape::Point.new(200, 100)
      
      point = [201, 100]
      
      _(shape.contain?(point)).must_equal false
      _(shape.contain?(point)).must_equal shape.contain?(*point)
      
      point = [200, 101]
      
      _(shape.contain?(point)).must_equal false
      
      point = [201, 101]
      
      _(shape.contain?(point)).must_equal false
    end
    
    it 'contains point within distance' do
      shape = PerfectShape::Point.new(200, 100)
      
      point = [200, 101]
      
      _(shape.contain?(point)).must_equal false
      _(shape.contain?(point, distance: 0.5)).must_equal false
      _(shape.contain?(point, distance: 1)).must_equal true
      _(shape.contain?(point, distance: 2)).must_equal true
      _(shape.contain?(point, distance: 1)).must_equal shape.contain?(*point, distance: 1)
    end
  end
end
