require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::CubicBezierCurve do
    it 'constructs with points' do
      shape = PerfectShape::CubicBezierCurve.new(points: [[200, 150], [230, 160], [270, 220], [180, 170]])

      _(shape.points).must_equal [[200, 150], [230, 160], [270, 220], [180, 170]]
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
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 230, 160, 270, 220, 180, 170])

      _(shape.points).must_equal [[200, 150], [230, 160], [270, 220], [180, 170]]
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
      shape = PerfectShape::CubicBezierCurve.new

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
      shape = PerfectShape::CubicBezierCurve.new
      shape.points = [[200, 150], [230, 160], [270, 220], [180, 170]]

      _(shape.points).must_equal [[200, 150], [230, 160], [270, 220], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35

      shape.points = [[201, 150], [230, 161], [270, 220], [180, 170]]

      _(shape.points).must_equal [[201, 150], [230, 161], [270, 220], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35

      shape.points << shape.points.pop

      _(shape.points).must_equal [[201, 150], [230, 161], [270, 220], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35
    end

    it 'equals another quadratic bezier curve' do
      shape = PerfectShape::CubicBezierCurve.new(points: [[200, 150], [230, 160], [270, 220], [180, 170]])
      shape2 = PerfectShape::CubicBezierCurve.new(points: [[200, 150], [230, 160], [270, 220], [180, 170]])

      _(shape).must_equal shape2
    end

    it 'does not equal a different quadratic bezier curve' do
      shape = PerfectShape::CubicBezierCurve.new(points: [[200, 150], [230, 160], [270, 220], [180, 170]])
      shape2 = PerfectShape::CubicBezierCurve.new(points: [[201, 151], [230, 160], [270, 220], [180, 170]])

      _(shape).wont_equal shape2
    end

    it 'contains point near edge' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      point = [270, 220]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near end' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      point = [201, 151]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point within bounding box' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      point = [200, 260]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside of bounding box' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      point = [0, 0]

      _(shape.contain?(point)).must_equal false
    end

    it 'contains point at center of outline' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      
      point = [261.875, 245.625]

      assert shape.contain?(point, outline: true)
    end
    
    it 'contains point at quarter of outline' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      
      point = [227.421875, 209.765625]

      assert shape.contain?(point, outline: true)
    end
    
    it 'contains point near beginning of outline' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      
      point = [203.28353881835938, 157.96096801757812]

      assert shape.contain?(point, outline: true)
    end
    
    it 'does not contain point outside outline' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      
      point = [227.421875, 210.765625]

      refute shape.contain?(point, outline: true)
    end
    
    it 'contains point outside outline with distance tolerance' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      
      point = [227.421875, 210.765625]

      assert shape.contain?(point, outline: true, distance_tolerance: 1.0)
    end
    
    it 'returns 2 subdivisions by default' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      
      subdivisions = shape.subdivisions
      _(subdivisions.count).must_equal 2
      _(subdivisions.map(&:class).uniq).must_equal [PerfectShape::CubicBezierCurve]
      _(subdivisions[0].points.flatten).must_equal [200.0, 150.0, 217.5, 192.5, 235.0, 235.0, 261.875, 245.625]
      _(subdivisions[1].points.flatten).must_equal [261.875, 245.625, 288.75, 256.25, 325.0, 235.0, 380.0, 150.0]
    end
    
    it 'returns 2 subdivisions for level 1' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      
      subdivisions = shape.subdivisions(1)
      _(subdivisions.count).must_equal 2
      _(subdivisions.map(&:class).uniq).must_equal [PerfectShape::CubicBezierCurve]
      _(subdivisions[0].points.flatten).must_equal [200.0, 150.0, 217.5, 192.5, 235.0, 235.0, 261.875, 245.625]
      _(subdivisions[1].points.flatten).must_equal [261.875, 245.625, 288.75, 256.25, 325.0, 235.0, 380.0, 150.0]
    end
    
    it 'returns 4 subdivisions for level 2' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      
      subdivisions = shape.subdivisions(2)
      
      _(subdivisions.count).must_equal 4
      _(subdivisions.map(&:class).uniq).must_equal [PerfectShape::CubicBezierCurve]
      _(subdivisions[0].points.flatten).must_equal [200.0, 150.0, 208.75, 171.25, 217.5, 192.5, 227.421875, 209.765625,]
      _(subdivisions[1].points.flatten).must_equal [227.421875, 209.765625, 237.34375, 227.03125, 248.4375, 240.3125, 261.875, 245.625]
      _(subdivisions[2].points.flatten).must_equal [261.875, 245.625, 275.3125, 250.9375, 291.09375, 248.28125, 310.390625, 233.671875]
      _(subdivisions[3].points.flatten).must_equal [310.390625, 233.671875, 329.6875, 219.0625, 352.5, 192.5, 380.0, 150.0]
    end
    
    it 'returns 8 subdivisions for level 3' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
      
      subdivisions = shape.subdivisions(3)
      
      _(subdivisions.count).must_equal 8
    end
    
    it 'returns point segment distance as 0' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
          
      point = [261.875, 245.625]

      _(shape.point_distance(point)).must_equal 0
      _(shape.point_distance(*point)).must_equal shape.point_distance(point)
    end
    
    it 'returns point segment distance as 10' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
          
      point = [261.875, 255.625]

      _(shape.point_distance(point)).must_equal 10
    end
    
    it 'returns point segment distance as 20' do
      shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 235, 235, 270, 320, 380, 150])
          
      point = [207.421875, 209.765625]

      _(shape.point_distance(point)).must_equal 20
    end
  end
end
