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
    
    it 'equals another point' do
      shape = PerfectShape::Point.new(200, 150)
      shape2 = PerfectShape::Point.new(200, 150)

      _(shape).must_equal shape2
    end

    it 'does not equal a different point' do
      shape = PerfectShape::Point.new(200, 150)
      shape2 = PerfectShape::Point.new(201, 150)

      _(shape).wont_equal shape2
      
      shape3 = PerfectShape::Point.new(200, 151)

      _(shape).wont_equal shape3
    end
    
    it 'contains point' do
      shape = PerfectShape::Point.new(200, 100)
      
      point = [200, 100]
      
      _(shape.contain?(point)).must_equal true
      _(shape.contain?(point)).must_equal shape.contain?(*point)
      _(shape.contain?(point)).must_equal shape.contain?(point, outline: true)
    end
    
    it 'does not contain point' do
      shape = PerfectShape::Point.new(200, 100)
      
      point = [201, 100]
      
      _(shape.contain?(point)).must_equal false
      _(shape.contain?(point)).must_equal shape.contain?(*point)
      _(shape.contain?(point)).must_equal shape.contain?(point, outline: true)
      
      point = [200, 101]
      
      _(shape.contain?(point)).must_equal false
      
      point = [201, 101]
      
      _(shape.contain?(point)).must_equal false
    end
    
    it 'contains point within distance' do
      shape = PerfectShape::Point.new(200, 100)
      
      point = [200, 101]
      
      _(shape.contain?(point)).must_equal false
      _(shape.contain?(point, distance_tolerance: 0.5)).must_equal false
      _(shape.contain?(point, distance_tolerance: 1)).must_equal true
      _(shape.contain?(point, distance_tolerance: 2)).must_equal true
      _(shape.contain?(point, distance_tolerance: 1)).must_equal shape.contain?(*point, distance_tolerance: 1)
    end
    
    it 'intersects with interior of rectangle through top edge' do
      shape = PerfectShape::Point.new(27, 3)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      
      assert shape.intersect?(rectangle)
    end
    
    it 'intersects with interior of rectangle through top-left corner' do
      shape = PerfectShape::Point.new(2, 3)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      
      assert shape.intersect?(rectangle)
    end
    
    it 'intersects with interior of rectangle by lying inside of it' do
      shape = PerfectShape::Point.new(27, 33)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      
      assert shape.intersect?(rectangle)
    end
    
    it 'does not intersect with interior of rectangle' do
      shape = PerfectShape::Point.new(0, 0)
      rectangle = PerfectShape::Rectangle.new(x: 2, y: 3, width: 50, height: 60)
      
      refute shape.intersect?(rectangle)
    end
  end
end
