require 'puts_debuggerer'
require 'minitest/autorun'

require_relative '../../../lib/perfect-shape'

describe PerfectShape do
  describe PerfectShape::QuadraticBezierCurve do
    it 'constructs with points' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [[200, 150], [270, 220], [180, 170]])

      _(shape.points).must_equal [[200, 150], [270, 220], [180, 170]]
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
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 220, 180, 170])

      _(shape.points).must_equal [[200, 150], [270, 220], [180, 170]]
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
      shape = PerfectShape::QuadraticBezierCurve.new

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
      shape = PerfectShape::QuadraticBezierCurve.new
      shape.points = [[200, 150], [270, 220], [180, 170]]

      _(shape.points).must_equal [[200, 150], [270, 220], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 150
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 70
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 150 + 35

      shape.points = [[201, 152], [270, 220], [180, 170]]

      _(shape.points).must_equal [[201, 152], [270, 220], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 152
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 68
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 152 + 34

      shape.points << shape.points.pop

      _(shape.points).must_equal [[201, 152], [270, 220], [180, 170]]
      _(shape.min_x).must_equal 180
      _(shape.min_y).must_equal 152
      _(shape.max_x).must_equal 270
      _(shape.max_y).must_equal 220
      _(shape.width).must_equal 90
      _(shape.height).must_equal 68
      _(shape.center_x).must_equal 180 + 45
      _(shape.center_y).must_equal 152 + 34
    end

    it 'equals another quadratic bezier curve' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [[200, 150], [270, 220], [180, 170]])
      shape2 = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 220, 180, 170])

      _(shape).must_equal shape2
    end

    it 'does not equal a different quadratic bezier curve' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 220, 180, 170])
      shape2 = PerfectShape::QuadraticBezierCurve.new(points: [201, 151, 271, 221, 181, 171])

      _(shape).wont_equal shape2
    end

    it 'contains point near edge' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      point = [270, 220]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'contains point near end' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      point = [201, 151]

      _(shape).must_be :contain?, point
      _(shape.contain?(point)).must_equal shape.contain?(*point)
    end

    it 'does not contain point within bounding box' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      point = [200, 260]

      _(shape.contain?(point)).must_equal false
    end

    it 'does not contain point outside of bounding box' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      point = [0, 0]

      _(shape.contain?(point)).must_equal false
    end

    it 'contains point at center of outline' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      
      point = [280, 235]
      
      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'contains point at quarter of outline' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      
      point = [327.5, 213.75]

      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'contains point near beginning of outline' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      
      point = [353.125, 187.1875]
      
      _(shape.contain?(point, outline: true)).must_equal true
    end

    it 'does not contain point on outline' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      
      point = [281, 235]
      
      _(shape.contain?(point, outline: true)).must_equal false
    end

    it 'contains point on outline with distance tolerance' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      
      point = [281, 235]
      
      _(shape.contain?(point, outline: true, distance_tolerance: 1)).must_equal true
    end
    
    it 'returns 2 subdivisions by default' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      
      subdivisions = shape.subdivisions
      _(subdivisions.count).must_equal 2
      _(subdivisions.map(&:class).uniq).must_equal [PerfectShape::QuadraticBezierCurve]
      _(subdivisions[0].points.flatten).must_equal [200.0, 150.0, 235.0, 235.0, 280.0, 235.0]
      _(subdivisions[1].points.flatten).must_equal [280.0, 235.0, 325.0, 235.0, 380.0, 150.0]
    end
    
    it 'returns 2 subdivisions for level 1' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      
      subdivisions = shape.subdivisions(1)
      _(subdivisions.count).must_equal 2
      _(subdivisions.map(&:class).uniq).must_equal [PerfectShape::QuadraticBezierCurve]
      _(subdivisions[0].points.flatten).must_equal [200.0, 150.0, 235.0, 235.0, 280.0, 235.0]
      _(subdivisions[1].points.flatten).must_equal [280.0, 235.0, 325.0, 235.0, 380.0, 150.0]
    end
    
    it 'returns 4 subdivisions for level 2' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      
      subdivisions = shape.subdivisions(2)
      
      _(subdivisions.count).must_equal 4
      _(subdivisions.map(&:class).uniq).must_equal [PerfectShape::QuadraticBezierCurve]
      _(subdivisions[0].points.flatten.map(&:to_f)).must_equal [200.0, 150.0, 217.5, 192.5, 237.5, 213.75]
      _(subdivisions[1].points.flatten.map(&:to_f)).must_equal [237.5, 213.75, 257.5, 235.0, 280.0, 235.0]
      _(subdivisions[2].points.flatten.map(&:to_f)).must_equal [280.0, 235.0, 302.5, 235.0, 327.5, 213.75]
      _(subdivisions[3].points.flatten.map(&:to_f)).must_equal [327.5, 213.75, 352.5, 192.5, 380.0, 150.0]
    end
    
    it 'returns 8 subdivisions for level 3' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
      
      subdivisions = shape.subdivisions(3)
      _(subdivisions.map(&:class).uniq).must_equal [PerfectShape::QuadraticBezierCurve]
      
      _(subdivisions.count).must_equal 8
    end
    
    it 'returns point segment distance as 0' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
          
      point = [280, 235]

      _(shape.point_segment_distance(point)).must_equal 0
      _(shape.point_segment_distance(*point)).must_equal shape.point_segment_distance(point)
    end
    
    it 'returns point segment distance as 10' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
          
      point = [280, 245]

      _(shape.point_segment_distance(point)).must_equal 10
    end
    
    it 'returns point segment distance as 20' do
      shape = PerfectShape::QuadraticBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
          
      point = [280, 255]

      _(shape.point_segment_distance(point)).must_equal 20
    end
  end
end
