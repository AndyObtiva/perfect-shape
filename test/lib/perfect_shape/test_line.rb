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

#     it 'updates attributes' do
#       shape = PerfectShape::Line.new
#       shape.points = [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
#
#       _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
#       _(shape.min_x).must_equal 180
#       _(shape.min_y).must_equal 150
#       _(shape.max_x).must_equal 270
#       _(shape.max_y).must_equal 220
#       _(shape.width).must_equal 90
#       _(shape.height).must_equal 70
#       _(shape.center_x).must_equal 180 + 45
#       _(shape.center_y).must_equal 150 + 35
#
#       shape.points = [200, 150]
#
#       _(shape.points).must_equal [[200, 150]]
#       _(shape.min_x).must_equal 200
#       _(shape.min_y).must_equal 150
#       _(shape.max_x).must_equal 200
#       _(shape.max_y).must_equal 150
#       _(shape.width).must_equal 0
#       _(shape.height).must_equal 0
#       _(shape.center_x).must_equal 200
#       _(shape.center_y).must_equal 150
#
#       shape.points << [270, 170]
#       shape.points << [250, 220]
#       shape.points << [220, 190]
#       shape.points << [200, 200]
#       shape.points << [180, 170]
#       shape.points.delete [180, 170]
#       shape.points << [180, 170]
#
#       _(shape.points).must_equal [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]]
#       _(shape.min_x).must_equal 180
#       _(shape.min_y).must_equal 150
#       _(shape.max_x).must_equal 270
#       _(shape.max_y).must_equal 220
#       _(shape.width).must_equal 90
#       _(shape.height).must_equal 70
#       _(shape.center_x).must_equal 180 + 45
#       _(shape.center_y).must_equal 150 + 35
#     end
#
#     it 'contains point in center' do
#       shape = PerfectShape::Line.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
#       point = [shape.center_x, shape.center_y]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'contains point near edge' do
#       shape = PerfectShape::Line.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
#       point = [235, 161]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'contains point near corner' do
#       shape = PerfectShape::Line.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
#       point = [269, 170]
#
#       _(shape).must_be :contain?, point
#       _(shape.contain?(point)).must_equal shape.contain?(*point)
#     end
#
#     it 'does not contain point within bounding box' do
#       shape = PerfectShape::Line.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
#       point = [235, 159]
#
#       _(shape.contain?(point)).must_equal false
#     end
#
#     it 'does not contain point outside of bounding box' do
#       shape = PerfectShape::Line.new(points: [[200, 150], [270, 170], [250, 220], [220, 190], [200, 200], [180, 170]])
#       point = [0, 0]
#
#       _(shape.contain?(point)).must_equal false
#     end
  end
end
