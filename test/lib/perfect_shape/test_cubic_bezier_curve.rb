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

#     it 'constructs with defaults' do
#       shape = PerfectShape::CubicBezierCurve.new
#
#       _(shape.points).must_equal []
#       _(shape.min_x).must_equal nil
#       _(shape.min_y).must_equal nil
#       _(shape.max_x).must_equal nil
#       _(shape.max_y).must_equal nil
#       _(shape.width).must_equal nil
#       _(shape.height).must_equal nil
#       _(shape.center_x).must_equal nil
#       _(shape.center_y).must_equal nil
#     end
#
#     it 'updates attributes' do
#       shape = PerfectShape::CubicBezierCurve.new
#       shape.points = [[200, 150], [270, 220], [180, 170]]
#
#       _(shape.points).must_equal [[200, 150], [270, 220], [180, 170]]
#       _(shape.min_x).must_equal 180
#       _(shape.min_y).must_equal 150
#       _(shape.max_x).must_equal 270
#       _(shape.max_y).must_equal 220
#       _(shape.width).must_equal 90
#       _(shape.height).must_equal 70
#       _(shape.center_x).must_equal 180 + 45
#       _(shape.center_y).must_equal 150 + 35
#
#       shape.points = [[201, 152], [270, 220], [180, 170]]
#
#       _(shape.points).must_equal [[201, 152], [270, 220], [180, 170]]
#       _(shape.min_x).must_equal 180
#       _(shape.min_y).must_equal 152
#       _(shape.max_x).must_equal 270
#       _(shape.max_y).must_equal 220
#       _(shape.width).must_equal 90
#       _(shape.height).must_equal 68
#       _(shape.center_x).must_equal 180 + 45
#       _(shape.center_y).must_equal 152 + 34
#
#       shape.points << shape.points.pop
#
#       _(shape.points).must_equal [[201, 152], [270, 220], [180, 170]]
#       _(shape.min_x).must_equal 180
#       _(shape.min_y).must_equal 152
#       _(shape.max_x).must_equal 270
#       _(shape.max_y).must_equal 220
#       _(shape.width).must_equal 90
#       _(shape.height).must_equal 68
#       _(shape.center_x).must_equal 180 + 45
#       _(shape.center_y).must_equal 152 + 34
#     end
#
#     it 'equals another quadratic bezier curve' do
#       shape = PerfectShape::CubicBezierCurve.new(points: [[200, 150], [270, 220], [180, 170]])
#       shape2 = PerfectShape::CubicBezierCurve.new(points: [200, 150, 270, 220, 180, 170])
#
#       _(shape).must_equal shape2
#     end
#
#     it 'does not equal a different quadratic bezier curve' do
#       shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 270, 220, 180, 170])
#       shape2 = PerfectShape::CubicBezierCurve.new(points: [201, 151, 271, 221, 181, 171])
#
#       _(shape).wont_equal shape2
#     end
#
#     it 'contains point near edge' do
#       shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
#       point = [270, 220]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'contains point near end' do
#       shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
#       point = [201, 151]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'does not contain point within bounding box' do
#       shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
#       point = [200, 260]
#
#       _(shape.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point outside of bounding box' do
#       shape = PerfectShape::CubicBezierCurve.new(points: [200, 150, 270, 320, 380, 150])
#       point = [0, 0]
#
#       _(shape.contain?(point)).must_equal false
#     end
  end
end
