require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::Polygon do
    it 'constructs with points' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])

      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'constructs with flattened points' do
      shape = PerfectShape::Polygon.new(points: [200, 150, 270, 170, 250, 220, 220, 190, 200, 200, 180, 170])

      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
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
      shape = PerfectShape::Polygon.new

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
      shape = PerfectShape::Polygon.new
      shape.points = [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]

      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
      
      shape.points = [200, 150]

      _(shape.points).must_equal [[200, 150]]
      _(shape.min_x).must_equal 200
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 200
      _(shape.max_y).must_equal 150
      _(shape.width).must_equal 0
      _(shape.height).must_equal 0
      _(shape.center_x).must_equal 200
      _(shape.center_y).must_equal 150
      
      shape.points << [270, 170]
      shape.points << [250, 220]
      shape.points << [220, 190]
      shape.points << [200, 200]
      shape.points << [180, 170]
      shape.points.delete [180, 170]
      shape.points << [180, 170]

      _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'equals another polygon' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
      shape2 = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])

      _(shape).must_equal shape2
    end

    it 'does not equal a different polygon' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
      shape2 = PerfectShape::Polygon.new(points: [[201, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])

      _(shape).wont_equal shape2
    end

    it 'contains point in center' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
      point = [shape.center_x, shape.center_y]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point in center when checking against outline only' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
      point = [shape.center_x, shape.center_y]

      _(shape.contain?(point, outline: true)).must_equal false
    end

    it 'contains point in outline' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
      point = [200, 150]

      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'contains point when checking against outline with distance tolerance' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
      point = [200, 151]

      _(shape.contain?(point, outline: true, distance_tolerance: 1)).must_equal true
    end

    it 'contains point near edge' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
      point = [235, 161]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near corner' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
      point = [269, 170]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end
    
    it 'does not contain point within bounding box' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
      point = [235, 159]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside of bounding box' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
      point = [0, 0]

      _(shape.contain?(point)).must_equal false
    end
    
    it 'returns edges of polygon' do
      shape = PerfectShape::Polygon.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
    
      expected_edges = [
        PerfectShape::Line.new(points: [[200, 150], [270, 170]]),
        PerfectShape::Line.new(points: [[270, 170], [250, 220]]),
        PerfectShape::Line.new(points: [[250, 220], [220, 190]]),
        PerfectShape::Line.new(points: [[220, 190], [200, 200]]),
        PerfectShape::Line.new(points: [[200, 200], [180, 170]]),
        PerfectShape::Line.new(points: [[180, 170], [200, 150]]),
      ]
    
      _(shape.edges).must_equal expected_edges
    end
  end
end
